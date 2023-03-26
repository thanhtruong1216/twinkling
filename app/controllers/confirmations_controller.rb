class ConfirmationsController < ApplicationController
  def new
    # binding.pry
  end

  def show
    redirect_to root_path
    # super do
    #   sign_in(resource) if resource.errors.empty?
    # end
  end

  # def after_confirmation_path_for(resource_name, resource)
  #   after_sign_in_path_for(resource)
  # end
end
