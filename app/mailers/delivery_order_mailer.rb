# frozen_string_literal: true

class DeliveryOrderMailer < ApplicationMailer
  default from: 'admin@employeerecognitionplatform.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_delivery_confirmation_email(order)
    @order = order
    mail(to: @order.employee.email,
         subject: "Your order #{@order.reward_snapshot.title} has been delivered.")
  end
end
