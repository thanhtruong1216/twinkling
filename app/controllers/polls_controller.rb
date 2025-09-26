class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @polls = Poll
      .includes(
        :options,
        { user: { avatar_attachment: :blob } },
        { options: { image_attachment: :blob } },
        :image_attachment
      )
      .order(created_at: :desc)

    # Gom tất cả option_ids từ các polls hiển thị
    option_ids = @polls.flat_map(&:option_ids)

    if current_user && option_ids.present?
      # 1 query duy nhất lấy danh sách option_id mà user đã vote
      @user_votes = current_user.votes
                                .where(option_id: option_ids)
                                .pluck(:option_id)
                                .to_set
    else
      @user_votes = Set.new
    end

    # Hot polls theo tổng số votes (counter cache)
    @hot_polls = Poll
      .includes(:user, :options)
      .order(votes_count: :desc)
      .limit(6)

    # Nếu cần dữ liệu JSON cho chart/frontend
    @polls_data = @polls.map do |poll|
      {
        id: poll.id,
        options: poll.options.map do |opt|
          {
            text: opt.text,
            votes: opt.votes_count
          }
        end
      }
    end
  end

  def show
    # Eager load options + user + image để tránh query khi render
    @poll = Poll
      .includes(:options, user: { avatar_attachment: :blob }, image_attachment: :blob)
      .find(params[:id])

    @options = @poll.options

    # Query tổng hợp: group theo country
    @votes_by_country = Vote.joins(:option)
                            .where(options: { poll_id: @poll.id })
                            .group(:country)
                            .count

    # Query tổng hợp: group theo option_id
    @votes_by_option = Vote.joins(:option)
                           .where(options: { poll_id: @poll.id })
                           .group(:option_id)
                           .count

    # Map option text -> số vote (dùng kết quả group trên)
    @votes_by_option_text = @options.map do |opt|
      [opt.text, @votes_by_option[opt.id] || 0]
    end.to_h

    set_meta_tags(
      title: @poll.title,
      description: @poll.purpose.presence,
      og: {
        title: @poll.title,
        description: @poll.purpose.presence,
        type: "website",
        url: request.original_url,
        image: @poll.image.attached? ? url_for(@poll.image) : view_context.image_url("studiovinari-brands.svg")
      }
    )
  end

  def new
    @poll = Poll.new
    3.times { @poll.options.build }
  end

  def create
    @poll = current_user.polls.build(poll_params)
    if @poll.save
      redirect_to @poll, notice: "Tạo poll thành công!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def update
    @poll = Poll.find(params[:id])
    if @poll.update(poll_params)
      redirect_to @poll, notice: "Poll đã được cập nhật thành công."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_visibility
    @poll = Poll.find(params[:id])
    if @poll.user == current_user
      @poll.update(visible: !@poll.visible)
      redirect_back fallback_location: user_path(current_user),
        notice: (@poll.visible ? "Poll đã hiển thị" : "Poll đã ẩn")
    else
      redirect_back fallback_location: user_path(current_user),
        alert: "Không thể chỉnh sửa poll này"
    end
  end

  private

  def poll_params
    params.require(:poll).permit(
      :title,
      :image,
      :description,
      :purpose,
      options_attributes: [:id, :text, :image, :_destroy]
    )
  end
end
