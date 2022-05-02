# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    sequence(:title) { |i| "Title#{format('%03d', i)}" }
    sequence(:content) { |i| "Content#{format('%03d', i)}" }
    giver { create(:employee) }
    receiver { create(:employee) }
    company_value
  end
end
