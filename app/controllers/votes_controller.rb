class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @option = Option.find(params[:option_id] || params.dig(:vote, :option_id))
    @poll = @option.poll
    @options = @poll.options
    @votes_by_country = @poll.votes.group(:country).count

    if @poll.votes.exists?(user_id: current_user.id)
      respond_to do |format|
        format.html { redirect_to @poll, alert: "Bạn đã vote rồi!" }
        format.js { render "update", layout: false }
      end
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

      @option.votes.create!(
        user: current_user,
        ip_address: ip,
        country: country
      )

      @poll.reload

      respond_to do |format|
        format.html { redirect_back fallback_location: poll_path(@poll), notice: "Vote thành công!" }
        format.js { render "update", layout: false }
      end
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
    @option = Option.find(params[:option_id])
    @poll = @option.poll
    @vote = @option.votes.find_by(user_id: current_user.id)
    @options = @poll.options
    @votes_by_country = @poll.votes.group(:country).count

    if @vote
      @vote.destroy
      @poll.reload
      respond_to do |format|
        format.html { redirect_back fallback_location: poll_path(@poll), notice: "Bạn đã unvote." }
        format.js { render "update", layout: false }
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: poll_path(@poll), alert: "Bạn chưa vote option này." }
        format.js { render "update", layout: false }
      end
    end
  end
end
