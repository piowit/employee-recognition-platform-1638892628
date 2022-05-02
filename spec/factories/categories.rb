# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:title) { |i| "Category#{format('%03d', i)}" }
  end
end
