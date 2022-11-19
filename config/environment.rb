require_relative 'application'

Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: 'plain',
  user_name: ENV['SENDGRID_USER_NAME'],
  password: ENV['SENDGRID_PASSWORD'],
  enable_starttls_auto: true,
  domain: 'twinkling-star.herokuapp.com'
}
