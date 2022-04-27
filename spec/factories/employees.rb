# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:email) { |i| "test#{i}@#{SecureRandom.base64(8)}.com" }
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
