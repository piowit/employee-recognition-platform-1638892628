# frozen_string_literal: true

FactoryBot.define do
  factory :company_value do
    sequence(:title) { |i| "Helpful#{i}" }
  end
end
