class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @option = Option.find(params[:option_id] || params.dig(:vote, :option_id))
    @poll   = Poll.includes(options: :votes).find(@option.poll_id)

    # Lấy IP + country
    ip = request.headers["CF-Connecting-IP"] || request.headers["X-Real-IP"] || request.remote_ip
    country = begin
                result = Geocoder.search(ip).first
                result&.country
              rescue
                nil
              end

    # Tạo vote nếu user chưa vote
    unless @option.votes.exists?(user_id: current_user.id)
      @option.votes.create!(
        user: current_user,
        ip_address: ip,
        country: country
      )
    end

    # Reset counter cache cho tất cả option trong poll
    @poll.options.each { |opt| Option.reset_counters(opt.id, :votes) }

    # Reload dữ liệu mới
    @poll.reload
    @poll.options.each(&:reload)
    @options = @poll.options
    @votes_by_country = @poll.votes.group(:country).count

    # Xác định action gọi từ request
    @current_request = begin
      referer = request.referer
      referer ? Rails.application.routes.recognize_path(URI(referer).path)[:action] : "show"
    rescue
      "show"
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: poll_path(@poll), notice: "Vote thành công!" }
      format.js   { render "update", layout: false }
    end
  end

  def destroy
    @option = Option.find(params[:option_id])
    @poll   = Poll.includes(:options, :votes).find(@option.poll_id)
    @vote   = @option.votes.find_by(user_id: current_user.id)

    if @vote
      @vote.destroy

      # Reset counter cache cho tất cả option trong poll
      @poll.options.each { |opt| Option.reset_counters(opt.id, :votes) }

      # Reload dữ liệu mới
      @poll.reload
      @poll.options.each(&:reload)
      @options = @poll.options
      @votes_by_country = @poll.votes.group(:country).count

      # Xác định action gọi từ request
      @current_request = begin
        referer = request.referer
        referer ? Rails.application.routes.recognize_path(URI(referer).path)[:action] : "show"
      rescue
        "show"
      end

      respond_to do |format|
        format.html { redirect_back fallback_location: poll_path(@poll), notice: "Bạn đã unvote." }
        format.js   { render "update", layout: false }
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: poll_path(@poll), alert: "Bạn chưa vote option này." }
        format.js   { render "update", layout: false }
      end
    end
  end

  def update
    @poll = Poll.find_by(id: params[:poll_id])
    vote = Vote.find_by(id: params[:id])

    unless vote.user_id == current_user.id
      redirect_back fallback_location: poll_path(@poll), alert: t('show.cannot_edit_vote', default: "You cannot edit this vote")
      return
    end

    if vote.update(comment: params[:vote][:comment])
      redirect_back fallback_location: poll_path(@poll), notice: t('show.comment_updated', default: "Comment updated")
    else
      redirect_back fallback_location: poll_path(@poll), alert: vote.errors.full_messages.to_sentence
    end
  end
end
