# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Title#{i}abc" }
    sequence(:description) { |i| "Description#{i}abc" }
    sequence(:price) { |i| i }
  end
end
