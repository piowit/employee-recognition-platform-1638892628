# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrderSearch.new(params).results.where(employee: current_employee)
  end

  def new
    @reward = Reward.find(params[:reward])
    return redirect_to rewards_path, notice: 'You have insufficient funds' if current_employee.points < @reward.price

    @employee = current_employee
    @address = @employee.address.nil? ? Address.new(employee: @employee) : Address.where(employee: @employee).last
    @order = Order.new(employee: @employee)
    render 'new'
  end

  def create
    @address = Address.new(order_params[:address])
    @create_order_service = CreateOrderService.new(order_params, current_employee)

    if @create_order_service.call
      redirect_to orders_path, notice: 'Reward bought'
    else
      render 'new',
             locals: { order: @create_order_service.order, reward: @create_order_service.reward, employee: current_employee }
    end
  end

  private

  def order_params
    params.require(:order).permit(:reward_id, address: %i[street postcode city])
  end
end
