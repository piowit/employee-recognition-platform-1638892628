# frozen_string_literal: true

class DeliveryOrderMailerPreview < ActionMailer::Preview
  def send_delivery_confirmation_email
    DeliveryOrderMailer.send_delivery_confirmation_email(FactoryBot.build(:order))
  end
end
