# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    before_action :authenticate_employee!

    def index
      @orders = Order.includes(:employee)
    end

    private

    def reward
      Reward.find(params[:reward])
    end
  end
end
