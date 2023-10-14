class UserManagementsController < ApplicationController
  def index
    if current_user.role == 'admin'
      @users = User.all
    else
      @users = []
    end
  end
end
