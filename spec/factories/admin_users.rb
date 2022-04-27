# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |i| "admin#{i}@#{SecureRandom.base64(8)}.com" }
    password { 'password' }
  end
end
