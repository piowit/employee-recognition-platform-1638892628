# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |i| "admin#{i}@admin.com" }
    password { 'password' }
  end
end
