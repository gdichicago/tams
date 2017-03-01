# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Set ActionMailer/SendGrid settings
ActionMailer::Base.smtp_settings = {
  :user_name => SENDGRID_USERNAME,
  :password => SENDGRID_PASSWORD,
  :domain => BASE_URL,
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
