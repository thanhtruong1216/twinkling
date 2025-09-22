class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # Lấy poll + tổng số votes bằng SQL thay vì tính trong Ruby
    @polls = Poll
      .left_joins(options: :votes)
      .select("polls.*, COUNT(votes.id) AS votes_count")
      .group("polls.id")
      .order(created_at: :desc)
      .includes(:options) # preload options để tránh N+1

    # Hot polls = nhiều votes nhất
    @hot_polls = @polls.order("votes_count DESC").limit(6)

    # Dữ liệu poll (dùng counter_cache nếu có)
    @polls_data = @polls.map do |poll|
      {
        id: poll.id,
        options: poll.options.map do |opt|
          {
            text: opt.text,
            votes: opt.respond_to?(:votes_count) ? opt.votes_count : opt.votes.size
          }
        end
      }
    end
  end

  def show
    @poll = Poll.includes(:options, :votes).find(params[:id])
    @options = @poll.options

    @votes_by_country = @poll.votes.group(:country).count
    @votes_by_option  = @poll.options.joins(:votes).group(:text).count
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
