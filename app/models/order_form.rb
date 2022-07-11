# frozen_string_literal: true

class OrderForm
  include ActiveModel::Model

  attr_accessor :reward, :delivery_method, :employee, :street,
                :postcode, :city, :address_id, :order

  def save
    r = Reward.find(reward)

    ActiveRecord::Base.transaction do
      if r.delivery_method == 'post'
        if address_id.present?
          a = Address.find(address_id)
          a.last_used = Time.current
          a.save!
        else
          a = Address.create!(employee: employee, street: street,
                              city: city, postcode: postcode, last_used: Time.current)
        end
      end

      @order = Order.create!(reward: r, reward_snapshot: r,
                             address_snapshot: a, employee: employee)
      if r.delivery_method == 'online'
        online_code = r.online_codes.available.first
        online_code.order = @order
        online_code.save!
      end
    end
    true
  rescue ActiveRecord::StatementInvalid => e
    errors.add(:base, e.message)
    false
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end
end
