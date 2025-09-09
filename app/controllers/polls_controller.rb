class PollsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @polls = Poll.includes(:options).order(created_at: :desc)
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.options
  end

  def new
    @poll = Poll.new
    2.times { @poll.options.build } # mặc định có 2 option
  end

  def create
    @poll = current_user.polls.build(poll_params)
    if @poll.save
      redirect_to @poll, notice: "Tạo poll thành công!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def poll_params
    params.require(:poll).permit(:title, options_attributes: [:text, :color])
  end
end
