class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # Eager load options để tránh N+1, dùng counter_cache để không query votes
    @polls = Poll
      .includes(:options)
      .order(created_at: :desc)

    @hot_polls = Poll
      .order(votes_count: :desc)
      .limit(6)

    # Build data cho chart: lấy trực tiếp từ counter_cache
    @polls_data = @polls.map do |poll|
      {
        id: poll.id,
        options: poll.options.map do |opt|
          {
            text: opt.text,
            votes: opt.votes_count # dùng counter_cache, không gọi .size
          }
        end
      }
    end
  end

  def show
    @poll = Poll.includes(:options).find(params[:id])
    @options = @poll.options

    # Đếm vote theo country (join options để lọc theo poll_id)
    @votes_by_country = Vote.joins(:option)
                            .where(options: { poll_id: @poll.id })
                            .group(:country)
                            .count

    # Đếm vote theo option
    @votes_by_option = Vote.joins(:option)
                          .where(options: { poll_id: @poll.id })
                          .group(:option_id)
                          .count

    # Map sang option text
    @votes_by_option_text = @poll.options.map { |opt| [opt.text, @votes_by_option[opt.id] || 0] }.to_h

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
