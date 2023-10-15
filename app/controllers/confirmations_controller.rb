class ConfirmationsController < ApplicationController
  def new
    # binding.pry
  end

  # def show
  #   redirect_to root_path
  # end


  protected

  def after_confirmation_path_for(resource_name, resource)
    new_session_path(resource_name, **utm_tracking_params)
  end
end
