# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'Title' }
    content { 'Content' }
    giver {}
    receiver {}
    company_value {}
  end
end
