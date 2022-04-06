# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Title#{format('%03d', i)}" }
    sequence(:description) { |i| "Description#{format('%03d', i)}" }
    sequence(:price) { |i| i }
  end
end
