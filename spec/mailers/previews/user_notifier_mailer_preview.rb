class UserNotifierMailerPreview < ActionMailer::Preview
  def user_notifier_mailer
    UserNotifierMailer.send_signup_email(User.last).deliver
  end
end
