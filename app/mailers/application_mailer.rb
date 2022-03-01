# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'pio.witek@gmail.com'
  layout 'mailer'
end
