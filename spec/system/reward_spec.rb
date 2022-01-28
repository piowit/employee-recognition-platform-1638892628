# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }
  let!(:company_value) { create(:company_value) }

  it 'test reward' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content 'Received Points: 0'

    click_link 'Show'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    visit rewards_path
    click_link 'Buy'
    expect(page).to have_content 'You have insufficient funds'

    create(:kudo, giver: employee, receiver: employee, company_value: company_value)

    visit rewards_path
    expect(page).to have_content 'Received Points: 1'
    click_link 'Buy'
    expect(page).to have_content 'Reward bought'
    expect(page).to have_content 'Received Points: 0'
  end
end
