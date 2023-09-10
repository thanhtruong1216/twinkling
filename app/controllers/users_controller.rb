class UsersController < ApplicationController
  before_action :find_user, only: %i[index show update following followers upload_avatar edit]

  def index
    @users = User.limit(10).page params[:page]
  end

  def show
  end

  def update
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
    search = params[:search]
    if search.present?
      user_name = search[:user_name]
      @users = User.where('full_name ILIKE ?', "%#{user_name}%") || User.where('user_name ILIKE ?', "%#{user_name}%")
    end
  end

  def upload_avatar
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :full_name, :email, :password, :password_confirmation, :avatar, :birthday)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
