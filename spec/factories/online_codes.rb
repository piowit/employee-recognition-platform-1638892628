# frozen_string_literal: true

FactoryBot.define do
  factory :online_code do
    code { Faker::IDNumber.unique.valid }
    reward
    order { nil }
  end
end
