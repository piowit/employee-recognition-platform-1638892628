# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    email { 'test1@test.com' }
    password { 'password' }
  end
end
