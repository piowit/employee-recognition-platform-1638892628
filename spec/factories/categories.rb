# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:title) { |i| SecureRandom.base64(20) + format('%03d', i) }
  end
end
