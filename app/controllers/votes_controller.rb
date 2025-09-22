class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    option = Option.find(params[:option_id] || params[:vote][:option_id])
    poll = option.poll

    if poll.votes.exists?(user_id: current_user.id)
      redirect_to poll, alert: "Bạn đã vote rồi!"
    else
      ip = request.headers["CF-Connecting-IP"] ||
          request.headers["X-Real-IP"]        ||
          request.remote_ip

      country = nil
      begin
        result = Geocoder.search(ip).first
        country = result.country if result
      rescue => e
        Rails.logger.error "Geocoder failed: #{e.message}"
      end

      option.votes.create!(
        user: current_user,
        ip_address: ip,
        country: country
      )

      redirect_back fallback_location: poll_path(poll), notice: "Vote thành công!"
    end
  end

  def update
    poll = Poll.find_by(id: params[:poll_id])
    vote = Vote.find_by(id: params[:id])
    unless vote.user_id == current_user.id
      redirect_back fallback_location: poll_path(poll), alert: t('show.cannot_edit_vote', default: "You cannot edit this vote")
      return
    end

    if vote.update(comment: params[:vote][:comment])
      redirect_back fallback_location: poll_path(poll), notice: t('show.comment_updated', default: "Comment updated")
    else
      redirect_back fallback_location: poll_path(poll), alert: vote.errors.full_messages.to_sentence
    end
  end

  def destroy
    option = Option.find(params[:option_id])
    vote = option.votes.find_by(user_id: current_user.id)

    if vote
      vote.destroy
      redirect_back fallback_location: poll_path(option.poll), notice: "Bạn đã unvote."
    else
      redirect_back fallback_location: poll_path(option.poll), alert: "Bạn chưa vote option này."
    end
  end
end
