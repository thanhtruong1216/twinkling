class Admin::PollsController < ApplicationController
  def index
    @polls = Poll.all.order(created_at: :desc)
  end

  def approve
    poll = Poll.find(params[:id])
    poll.update!(status: "approved")
    redirect_to admin_polls_path, notice: "Poll đã được duyệt!"
  end

  def reject
    poll = Poll.find(params[:id])
    poll.update!(status: "rejected")
    redirect_to admin_polls_path, alert: "Poll đã bị từ chối!"
  end
end
