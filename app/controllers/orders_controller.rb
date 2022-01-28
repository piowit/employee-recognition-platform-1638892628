# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def create
    result = OrderCreator.new.call(employee: current_employee, reward: reward)

    if result.success?
      redirect_to rewards_path, notice: result.value!
    else
      redirect_to rewards_path, notice: result.failure
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
