class UsersController < ApplicationController
  def index
    @users = User.limit(10).page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    render 'following'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    render 'follower'
  end

  def search
    search = params[:search]
    if search.present?
      user_name = search[:user_name]

      @users = User.where('user_name ILIKE ?', "%#{user_name}%")
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect root_path
    else
      render "index"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :full_name, :email, :password, :password_confirmation, :avatar)
  end
end
