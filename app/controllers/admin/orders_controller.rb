# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.includes(:employee).order(:delivered)
    end

    def deliver
      @order = Order.find(params[:id])
      if @order.delivered
        redirect_to admin_orders_path, notice: 'Order already delivered'
      else
        @order.delivered = true
        if @order.save
          redirect_to admin_orders_path, notice: 'Order delivered'
        else
          redirect_to admin_orders_path, notice: 'Error'
        end
      end
    end
  end
end
