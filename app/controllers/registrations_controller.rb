class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :user_name, :full_name, :password, :password_confirmation, :encrypted_password)
  end

  def account_update_params
    params.require(:user).permit(:email, :user_name, :full_name, :password, :password_confirmation, :current_password, :birthday, :blood)
  end
end
