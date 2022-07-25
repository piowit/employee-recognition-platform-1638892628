# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    employee
    reward
    reward_snapshot { reward }
    address_snapshot { build(:address) }
    delivery_type { 'post' }
  end
end
