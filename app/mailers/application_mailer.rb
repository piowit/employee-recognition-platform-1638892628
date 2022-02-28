# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'do-not-reply@employeerecognitionplatfrom.herokuapp.com'
  layout 'mailer'
end
