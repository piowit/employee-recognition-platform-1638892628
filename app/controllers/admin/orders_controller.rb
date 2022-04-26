# frozen_string_literal: true

require 'csv'

module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.includes(:employee).order(:delivered)
    end

    def export
      @orders = Order.includes(:employee).order(:delivered)

      response.headers['Content-Type'] = 'text/csv'
      response.headers['Content-Disposition'] = "attachment; filename=orders_#{Time.zone.now.strftime('%y%m%d_%H-%M-%S')}.csv"
      render template: 'admin/orders/export', handlers: [:erb], formats: [:csv]
    end
  end
end
