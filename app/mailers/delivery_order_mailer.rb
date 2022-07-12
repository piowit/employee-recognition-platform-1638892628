# frozen_string_literal: true

class DeliveryOrderMailer < ApplicationMailer
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_delivery_confirmation_email
    @order = params[:order]
    mail(to: @order.employee.email,
         subject: "Your order #{@order.reward_snapshot.title} has been delivered.")
  end

  def send_online_code_delivery_email
    @order = params[:order]
    @online_code = params[:code]
    mail(to: @order.employee.email,
         subject: "Your order #{@order.reward_snapshot.title} has been delivered.")
  end
end
