class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    render layout: false
  end

  def destroy
    puts 'params', params
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    render layout: false
  end
end
