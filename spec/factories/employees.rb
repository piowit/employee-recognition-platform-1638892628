# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) { |i| "Piotr#{i}" }
    sequence(:last_name) { |i| "Witek#{i}" }
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
