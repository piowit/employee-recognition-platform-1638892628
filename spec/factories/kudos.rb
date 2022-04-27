# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { SecureRandom.base64(20) }
    content { SecureRandom.base64(20) }
    giver { create(:employee) }
    receiver { create(:employee) }
    company_value
  end
end
