# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = case params[:filter]
              when 'delivered'
                Order.where(employee: current_employee, delivered: true)
              when 'notDelivered'
                Order.where(employee: current_employee, delivered: false)
              else
                Order.where(employee: current_employee)
              end
  end

  def create
    if current_employee.points < reward.price
      redirect_to rewards_path, notice: 'You have insufficient funds'
    else
      @order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
      if @order.save
        redirect_to rewards_path, notice: 'Reward bought'
      else
        redirect_to rewards_path, notice: 'Error'
      end
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
