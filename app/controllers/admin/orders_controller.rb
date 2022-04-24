# frozen_string_literal: true

require 'csv'

module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.includes(:employee).order(:delivered)
    end

    def export
      @orders = Order.order(:delivered)

      respond_to do |format|
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = 'attachment; filename=orders.csv'
          # render template: 'admin/orders/export.csv.erb'
          render template: 'admin/orders/export', handlers: [:erb], formats: [:csv]
        end
      end
    end
  end
end
