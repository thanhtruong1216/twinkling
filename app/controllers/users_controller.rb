class UsersController < ApplicationController
  before_action :find_user, only: %i[show update following followers upload_avatar edit]

  def index
    @users = User.limit(10).page params[:page]
  end

  def show
  end

  def update
    EventTrack.create(name: 'Update profile', user_id: current_user.id)
    
    if @user.update(user_params)
      redirect_to user_path
    else
      redirect_to root_path
    end
  end

  def following
    @title = 'Following'
    render 'following'
  end

  def followers
    @title = 'Followers'
    render 'follower'
  end

  def search
    EventTrack.create(name: 'Search user', user_id: current_user.id)

    search = params[:search]
    if search.present?
      user_name = search[:user_name]
      @users = User.where('user_name ILIKE ?', "%#{user_name}%")
    end
  end

  def upload_avatar
    EventTrack.create(name: 'Upload new avatar', user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :full_name, :email, :password, :password_confirmation, :avatar, :birthday, :blood)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
