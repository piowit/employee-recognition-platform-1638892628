# frozen_string_literal: true

class CreateOrderService
  attr_reader :errors, :order, :reward, :address

  def initialize(params:, employee:)
    @order = Order.new(reward: @reward, reward_snapshot: @reward, address_snapshot: @address, employee: @employee)
    @reward = Reward.find(params[:reward_id])
    @employee = employee

    @address = @employee.address || Address.new(employee: @employee)
    @street = params.dig(:address, :street)
    @city = params.dig(:address, :city)
    @postcode = params.dig(:address, :postcode)

    @errors = []
  end

  def call
    return false unless items_in_stock?
    return false unless sufficient_funds?

    ActiveRecord::Base.transaction do
      update_address if @reward.post?
      create_order
      decrease_item_stock if @reward.post?
      assign_online_code if @reward.online?
    end
    deliver_email

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
    @errors << e.message
    false
  end

  private

  def items_in_stock?
    return true if @reward.number_of_available_items.positive?

    @errors << 'Not enough items in stock'
    false
  end

  def sufficient_funds?
    return true if @employee.points >= @reward.price

    @errors << 'You have insufficient funds'
    false
  end

  def update_address
    @address.update!(city: @city, postcode: @postcode, street: @street, last_used: Time.current)
  end

  def create_order
    @order.update!(reward: @reward, reward_snapshot: @reward, address_snapshot: @address, employee: @employee)
  end

  def decrease_item_stock
    @reward.decrement(:available_items).save!
  end

  def assign_online_code
    @online_code = OnlineCode.available.where(reward: @reward).first
    @online_code.update!(order: @order)
  end

  def deliver_email
    return if @reward.post?

    DeliveryOrderMailer.with(order: @order, code: @online_code.code).online_code_delivery_email.deliver
    @order.update!(delivered: true) if @order.reward_snapshot.delivery_method == 'online'
  end
end
