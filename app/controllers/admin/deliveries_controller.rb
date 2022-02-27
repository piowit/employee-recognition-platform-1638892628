# frozen_string_literal: true

module Admin
  class DeliveriesController < AdminController
    def update
      @order = Order.find(params[:id])
      if @order.delivered
        DeliveryOrderMailer.send_delivery_confirmation_email(@order).deliver_now
        redirect_to admin_orders_path, notice: 'Order already delivered'
      else
        @order.delivered = true
        if @order.save
          DeliveryOrderMailer.send_delivery_confirmation_email(@order).deliver_now
          redirect_to admin_orders_path, notice: 'Order delivered'
        else
          redirect_to admin_orders_path, notice: 'Error'
        end
      end
    end
  end
end
