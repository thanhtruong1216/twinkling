class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    option = Option.find(params[:option_id])
    poll = option.poll

    # check nếu user đã vote rồi
    if poll.votes.exists?(user_id: current_user.id)
      redirect_to poll, alert: "Bạn đã vote rồi!"
    else
      option.votes.create!(user: current_user)
      redirect_to poll, notice: "Vote thành công!"
    end
  end
end
