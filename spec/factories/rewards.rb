# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Title#{i}" }
    sequence(:description) { |i| "Description#{i}" }
    sequence(:price) { |i| i }
  end
end
