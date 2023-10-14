class UserManagementsController < ApplicationController
  def index
    if current_user.role == 'admin'
      @users = User.all.order(west_zodiac: :asc)
    else
      @users = []
    end
  end
end
