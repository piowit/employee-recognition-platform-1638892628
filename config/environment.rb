# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  password: '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', # This is the secret sendgrid API key which was issued during API key creation
  domain: 'localhost',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
