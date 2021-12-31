# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    email { '1test@test.com' }
    password { 'password' }
  end
end
