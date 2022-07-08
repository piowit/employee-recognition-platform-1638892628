# frozen_string_literal: true

class CreateOrderService
  include ActiveModel::Validations

  attr_reader :errors, :reward, :address_id, :street, :city, :postcode

  def initialize(params = nil)
    # params = [:reward, :delivery_method, :street, :postcode, :city, :address_id]
    if params.present?
      @reward = Reward.find(params[:reward])
      @employee = params[:employee]
      @street = params[:street]
      @postcode = params[:postcode]
      @city = params[:city]
      @address = params[:address_id].present? ? Address.find(params[:address_id]) : nil
    end
    @errors = ActiveModel::Errors.new(self)
  end

  def call
    ActiveRecord::Base.transaction do
      check_funds
      take_or_create_address if @reward.delivery_method == 'post'
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

  def check_funds
    raise StandardError, 'You have insufficient funds' if @employee.points < @reward.price
  end

  def take_or_create_address
    return @address.update!(last_used: Time.current) if @address.present?

    @address = Address.create!(employee: @employee, street: @street, city: @city, postcode: @postcode, last_used: Time.current)
  end

  def create_order
    @order = Order.create!(reward: @reward, reward_snapshot: @reward, address_snapshot: @address, employee: @employee)
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
