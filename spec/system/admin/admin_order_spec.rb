# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin_user) }
  let!(:company_value) { create(:company_value) }
  let!(:reward) { create(:reward, price: 1) }
  let(:reward2) { create(:reward, price: 2) }

  it 'tests order' do
    # visit root_path
    create(:kudo, giver: employee, receiver: employee, company_value: company_value)
    login_as employee, scope: :employee
    login_as admin, scope: :admin_user

    visit orders_path
    expect(page).not_to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).not_to have_content reward.price

    visit rewards_path
    expect(page).to have_content reward.title
    click_link 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    visit admin_rewards_path
    expect(page).to have_content reward.title
    click_link 'Edit'
    fill_in 'reward[title]', with: reward2.title
    fill_in 'reward[description]', with: reward2.description
    fill_in 'reward[price]', with: reward2.price
    click_button 'Update Reward'
    expect(page).to have_content reward2.title
    expect(page).to have_content reward2.description
    expect(page).to have_content reward2.price

    visit orders_path
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).not_to have_content reward2.title
    expect(page).not_to have_content reward2.description
    expect(page).not_to have_content reward2.price
  end
end
