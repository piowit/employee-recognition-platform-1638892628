# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  password: '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',  # ENV['SENDGRID_API_KEY'], # This is the secret sendgrid API key which was issued during API key creation
  domain: 'localhost',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
