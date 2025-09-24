class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @polls = Poll
      .left_joins(options: :votes)
      .select("polls.*, COUNT(votes.id) AS votes_count")
      .group("polls.id")
      .order(created_at: :desc)
      .includes(:options)

    @hot_polls = @polls.order("votes_count DESC").limit(6)
    if request.referer.present?
      referer_path = URI(request.referer).path rescue nil
      @current_action = Rails.application.routes.recognize_path(referer_path)[:action] if referer_path
    else
      @current_action = action_name
    end

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
