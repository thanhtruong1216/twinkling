class UserNotifierMailer < ApplicationMailer
  default :from => 'BloodMoon<rosy03122022@gmail.com>'
  layout 'mailer'

  def send_signup_email(user)
    @user = user
    
    headers(
      'X-SMTPAPI' => {
        category: 'sign_up'
      }.to_json
    )

    mail(
      from: 'BloodMoon<rosy03122022@gmail.com>',
      to:      @user.email,
      subject: 'Thanks for signing up for our amazing app'
    )
  end
end
