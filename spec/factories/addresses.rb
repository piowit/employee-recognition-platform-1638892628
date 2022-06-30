# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    employee
    sequence(:street) { |i| "Polna #{i}" }
    sequence(:postcode) { |i| "00-#{format('%03d', i)}" }
    sequence(:city) { |i| "Warszawa#{i}" }
    last_used { Time.current }
  end
end
