# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrderSearch.new(params).results.where(employee: current_employee)
  end

  def new
    @reward = Reward.find(params[:reward])
    return redirect_to rewards_path, notice: 'You have insufficient funds' if current_employee.points < @reward.price

    @create_order_service = CreateOrderService.new
    render 'new', locals: { order: @create_order_service, reward: @reward, employee: current_employee }
  end

  def create
    @create_order_service = CreateOrderService.new(order_params)
    if @create_order_service.call
      redirect_to orders_path, notice: 'Reward bought'
    else
      render 'new', locals: { order: @create_order_service, reward: @create_order_service.reward, employee: current_employee },
                    notice: @create_order_service.errors
    end
  end

  private

  def order_params
    cos = params.require(:create_order_service).permit(:reward, :delivery_method, :street, :postcode, :city, :address_id)
    cos[:employee] = current_employee
    cos
  end
end
