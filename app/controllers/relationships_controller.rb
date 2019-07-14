class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    render layout: false
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    render layout: false
  end
end
