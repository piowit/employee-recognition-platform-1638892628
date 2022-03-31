# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Title#{'%3d' % i}" }
    sequence(:description) { |i| "Description#{'%3d' % i}" }
    sequence(:price) { |i| i }
  end
end
