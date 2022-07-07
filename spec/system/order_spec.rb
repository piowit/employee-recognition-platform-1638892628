# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1, available_items: 1) }
  let!(:company_value) { create(:company_value) }
  let!(:online_code) { create(:online_code, reward: reward) }

  it 'tests order' do
    online_code
    create(:kudo, giver: employee, receiver: employee, company_value: company_value)
    login_as employee, scope: :employee

    visit orders_path
    expect(page).not_to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).not_to have_content reward.price

    visit rewards_path
    expect(page).to have_content 'Received Points: 1'
    expect(page).to have_content reward.title
    click_link 'Buy'
    expect(page).to have_content reward.title
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
  end
end
