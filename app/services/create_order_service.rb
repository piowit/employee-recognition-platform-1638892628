# frozen_string_literal: true

class CreateOrderService
  include ActiveModel::Validations

  attr_reader :errors

  def initialize(params)
    @reward = Reward.find(params[:reward_id])
    @employee = params[:employee]
    @address = Address.new(city: params.dig(:address, :city), postcode: params.dig(:address, :postcode),
                           street: params.dig(:address, :street), last_used: Time.current, employee: @employee)
    @errors = ActiveModel::Errors.new(self)
  end

  def call
    ActiveRecord::Base.transaction do
      check_items_stock
      check_funds
      save_address if @reward.delivery_method == 'post'
      create_order
      decrease_item_stock if @reward.delivery_method == 'post'
      assign_online_code if @reward.delivery_method == 'online'
      deliver_online_code if @reward.delivery_method == 'online'
    end

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid, StandardError => e
    @errors.add(:base, e.message)
    false
  end

  private

  def check_items_stock
    return true if @reward.delivery_method == 'post' && @reward.available_items.positive?
    return true if @reward.delivery_method == 'online' && @reward.online_codes_count.positive?

    raise StandardError, 'Not enough items in stock'
  end

  def check_funds
    raise StandardError, 'You have insufficient funds' if @employee.points < @reward.price
  end

  def save_address
    @address.save!
  end

  def create_order
    @order = Order.new(reward: @reward, reward_snapshot: @reward, address_snapshot: @address, employee: @employee)
    @order.valid? ? @order.save! : @errors.merge!(@order)
  end

  def decrease_item_stock
    @reward.update!(available_items: @reward.available_items - 1)
  end

  def assign_online_code
    @online_code = OnlineCode.available.where(reward: @reward).first
    @online_code.update!(order: @order)
  end

  def deliver_online_code
    @order.update!(delivered: true)
    DeliveryOrderMailer.with(order: @order).send_delivery_confirmation_email.deliver_now
  end
end
