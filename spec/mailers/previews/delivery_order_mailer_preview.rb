# frozen_string_literal: true

class DeliveryOrderMailerPreview < ActionMailer::Preview
  def delivery_confirmation_email
    DeliveryOrderMailer.with(order: FactoryBot.build(:order)).delivery_confirmation_email
  end
end
