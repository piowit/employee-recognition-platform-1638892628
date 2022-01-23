# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'Title' }
    content { 'Content' }
    giver_of_kudo {}
    receiver_of_kudo {}
    company_value {}
  end
end
