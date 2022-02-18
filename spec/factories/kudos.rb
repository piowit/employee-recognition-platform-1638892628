# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'Title' }
    content { 'Content' }
    giver { create(:employee) }
    receiver { create(:employee) }
    company_value
  end
end
