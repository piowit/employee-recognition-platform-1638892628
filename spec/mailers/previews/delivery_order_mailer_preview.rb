# frozen_string_literal: true

class DeliveryOrderMailerPreview < ActionMailer::Preview
  def send_delivery_confirmation_email
    DeliveryOrderMailer.with(order: FactoryBot.build(:order)).send_delivery_confirmation_email
  end
end
