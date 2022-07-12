# frozen_string_literal: true

class CreateOrderService
  attr_reader :errors, :order, :reward, :address

  def initialize(params, employee)
    @reward = Reward.find(params[:reward_id])
    @employee = employee

    @address = @employee.address || Address.new(employee: @employee)
    @street = params.dig(:address, :street)
    @city = params.dig(:address, :city)
    @postcode = params.dig(:address, :postcode)

    @errors = []
  end

  def call
    return false unless check_items_stock
    return false unless check_funds

    ActiveRecord::Base.transaction do
      update_address if @reward.delivery_method == 'post'
      create_order
      decrease_item_stock if @reward.delivery_method == 'post'
      assign_online_code if @reward.delivery_method == 'online'
    end
    deliver_email

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
    @errors << e.message
    false
  end

  private

  def check_items_stock
    return true if @reward.delivery_method == 'post' && @reward.available_items.positive?
    return true if @reward.delivery_method == 'online' && @reward.online_codes_count.positive?

    @errors << 'Not enough items in stock'
    false
  end

  def check_funds
    return true if @employee.points >= @reward.price

    @errors << 'You have insufficient funds'
    false
  end

  def update_address
    @address.update!(city: @city, postcode: @postcode, street: @street, last_used: Time.current)
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

  def deliver_email
    if @reward.delivery_method == 'post'
      DeliveryOrderMailer.with(order: @order).send_delivery_confirmation_email.deliver
    else
      DeliveryOrderMailer.with(order: @order, code: @online_code.code).send_online_code_delivery_email.deliver
    end
    @order.update!(delivered: true) if @order.reward_snapshot.delivery_method == 'online'
  end
end
