class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :user_name, :full_name, :password, :password_confirmation, :encrypted_password)
  end

  def account_update_params
    params.require(:user).permit(:email, :user_name, :full_name, :password, :password_confirmation, :current_password, :birthday, :blood)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end 
end
