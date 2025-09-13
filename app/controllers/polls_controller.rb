class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @polls = Poll.includes(:options).order(created_at: :desc)
    @polls_data = @polls.map do |poll|
      {
        id: poll.id,
        options: poll.options.map do |opt|
          { text: opt.text, votes: opt.votes.count }
        end
      }
    end
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.options
  end

  def new
    @poll = Poll.new
    2.times { @poll.options.build }
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
