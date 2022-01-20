# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

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

    click_link 'Show'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
  end
end
