# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :reward_find, only: [:create]

  def index
    @orders = Order.all
  end

  def create
    if current_employee.points < @reward.price
      redirect_to rewards_path, notice: 'You have insufficient funds'
    else
      @order = Order.new(employee: current_employee, reward: @reward)
      if @order.save
        redirect_to rewards_path, notice: 'Reward bought'
      else
        redirect_to rewards_path, notice: 'Error'
      end
    end
  end

  private

  def reward_find
    @reward = Reward.find(params[:reward])
  end
end
