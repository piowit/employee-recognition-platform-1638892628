# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| SecureRandom.base64(20) + format('%03d', i) }
    sequence(:description) { |i| SecureRandom.base64(20) + format('%03d', i) }
    sequence(:price) { |i| i }
  end
end
