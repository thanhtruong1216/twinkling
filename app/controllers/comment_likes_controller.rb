class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote

  def create
    @like = @vote.comment_likes.new(user: current_user)
    if @like.save
      @liked = true
    else
      @liked = false
    end
    @vote.reload
    respond_to do |format|
      format.js { render "update", layout: false }
      format.html { redirect_back fallback_location: poll_path(@vote.option.poll), notice: "Liked!" }
    end
  end

  def destroy
    @vote.comment_likes.find_by(user: current_user)&.destroy
    @liked = false
    @vote.reload
    respond_to do |format|
      format.js { render "update", layout: false }
      format.html { redirect_back fallback_location: poll_path(@vote.option.poll), notice: "Unliked!" }
    end
  end

  private

  def set_vote
    @vote = Vote.find(params[:vote_id])
    @poll = @vote.option.poll
  end
end
