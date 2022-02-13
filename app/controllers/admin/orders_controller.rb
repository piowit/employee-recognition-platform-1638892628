# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    before_action :authenticate_employee!

    def index
      @orders = Order.includes(:employee)
    end
  end
end
