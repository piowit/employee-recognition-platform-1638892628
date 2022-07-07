# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrderSearch.new(params).results.where(employee: current_employee)
  end

  def new
    order_form = OrderForm.new
    render 'new', locals: { order_form: order_form, reward: reward, employee: current_employee }
  end

  def create
    reward = Reward.find(order_form_params[:reward])
    return redirect_to rewards_path, notice: 'You have insufficient funds' if current_employee.points < reward.price

    order_form = OrderForm.new(order_form_params)

    ActiveRecord::Base.transaction do
      order_form.save
      if order_form.order.reward_snapshot.delivery_method == 'online'
        DeliveryOrderMailer.with(order: order_form.order).send_delivery_confirmation_email.deliver_now
        order_form.order.update!(delivered: true)
      end
      redirect_to orders_path, notice: 'Reward bought'
    end
  rescue ActiveRecord::RecordInvalid => e
    render 'new', locals: { order_form: order_form, reward: reward, delivery_method: reward.delivery_method,
                            employee: current_employee }, notice: e
  end

  private

  def order_form_params
    ofp = params.require(:order_form).permit(:reward, :delivery_method, :street, :postcode, :city, :address_id)
    ofp[:employee] = current_employee
    ofp
  end

  def reward
    Reward.find(params[:reward])
  end
end
