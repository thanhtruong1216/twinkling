class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    option = Option.find(params[:option_id])
    poll = option.poll

    if poll.votes.exists?(user_id: current_user.id)
      redirect_to poll, alert: "Bạn đã vote rồi!"
    else
      option.votes.create!(user: current_user)
      redirect_to poll, notice: "Vote thành công!"
    end
  end

  def destroy
    option = Option.find(params[:option_id])
    vote = option.votes.find_by(user_id: current_user.id)

    if vote
      vote.destroy
      redirect_to option.poll, notice: "Bạn đã unvote."
    else
      redirect_to option.poll, alert: "Bạn chưa vote option này."
    end
  end
end
