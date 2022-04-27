# frozen_string_literal: true

FactoryBot.define do
  factory :company_value do
    sequence(:title) { |i| SecureRandom.base64(20) + format('%03d', i) }
  end
end
