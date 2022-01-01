# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'Title' }
    content { 'Content' }
    association :giver_of_kudo, factory: :employee
    association :receiver_of_kudo, factory: :employee
  end
end
