class Admin::PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :approve, :reject, :destroy]

  def index
    @polls = Poll.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @poll = Poll.new
    2.times { @poll.options.build }
  end

  def create
    @poll = Poll.new(poll_params)
    if @poll.save
      redirect_to admin_poll_path(@poll), notice: "Poll đã được tạo thành công!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @poll.update(poll_params)
      redirect_to admin_poll_path(@poll), notice: "Poll đã được cập nhật!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @poll.destroy
    redirect_to admin_polls_path, notice: "Poll đã bị xóa!"
  end

  def approve
    @poll.update!(status: "approved")
    redirect_to admin_polls_path, notice: "Poll đã được duyệt!"
  end

  def reject
    @poll.update!(status: "rejected")
    redirect_to admin_polls_path, alert: "Poll đã bị từ chối!"
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(:title, :description, :status, options_attributes: [:id, :text, :_destroy])
  end
end
