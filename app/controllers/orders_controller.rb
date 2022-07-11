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
    @reward = Reward.find(order_params[:reward_id])
    @address = Address.new(order_params[:address])
    @order = Order.new(reward: @reward, reward_snapshot: @reward, address_snapshot: @address, employee: @employee)
    return redirect_to rewards_path, notice: 'You have insufficient funds' if current_employee.points < @reward.price

    @create_order_service = CreateOrderService.new(order_params)
    if @create_order_service.call
      redirect_to orders_path, notice: 'Reward bought'
    else
      render 'new', locals: { order: @order, reward: @order.reward, employee: current_employee }
    end
    # @order.reward_snapshot = Reward.find(order_params[:reward_id])
    # @order.address_snapshot = Address.new(order_params.dig(:employee_attributes, :address_attributes))
    # @reward.update!(available_items: @reward.available_items - 1)
    # if @order.save
    #   redirect_to orders_path, notice: 'Reward bought'
    # else
    #   render 'new', locals: { order: @order, reward: @order.reward, employee: current_employee },
    #                 notice: @order.errors
    # end
  end

  private

  def order_params
    cos = params.require(:order).permit(:reward_id, address: %i[street postcode city])
    cos[:employee] = current_employee
    cos
  end
end
