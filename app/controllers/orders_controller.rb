# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrderSearch.new(params).results.where(employee: current_employee)
  end

  def new
    reward = Reward.find(params[:reward])
    return redirect_to rewards_path, notice: 'You have insufficient funds' if current_employee.points < reward.price

    employee = current_employee
    address = employee.address.nil? ? Address.new(employee: employee) : Address.where(employee: employee).last
    order = Order.new(employee: @employee)
    render 'new', locals: { order: order, reward: reward, address: address, employee: employee }
  end

  def create
    create_order_service = CreateOrderService.new(params: order_params, employee: current_employee)

    if create_order_service.call
      redirect_to orders_path, notice: 'Reward bought'
    else
      flash.now.notice = create_order_service.errors.join(', ')
      render 'new',
             locals: { order: create_order_service.order, reward: create_order_service.reward,
                       address: create_order_service.address, employee: current_employee }
    end
  end

  private

  def order_params
    params.require(:order).permit(:reward_id, address: %i[street postcode city])
  end
end
