class SessionsController < ApplicationController
  def new
  end
  
  def create
    if User.find_by_email(params[:user][:email]).present?
      super
      if User.find_by_email(params[:user][:email]).try(:confirmed_at).present?
        super
      else
        redirect_to :back, notice: 'Please confirm your email first'
      end
    else
      redirect_to :back, notice: 'User not found'
    end
  end
end
