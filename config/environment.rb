# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com', 
  port: 587, 
  domain: 'http://localhost:3000/', 
  user_name: ENV[:email], 
  password: ENV[:password]
}