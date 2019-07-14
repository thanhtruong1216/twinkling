class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    render layout: false
  end

  def destroy
    relationship = Relationship.find(params[:id])
    @user = relationship.followed
    relationship.destroy
    render layout: false
  end
end
