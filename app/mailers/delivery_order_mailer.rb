# frozen_string_literal: true

class DeliveryOrderMailer < ApplicationMailer
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_delivery_confirmation_email
    @order = params[:order]
    @online_code = @order&.online_code&.code if @order&.reward_snapshot&.delivery_method == 'online'
    mail(to: @order.employee.email,
         subject: "Your order #{@order.reward_snapshot.title} has been delivered.")
  end
end
