# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }

  it 'test admin rewards crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Rewards'

    click_link 'New Reward'
    fill_in 'reward[title]', with: 'test reward title1'
    fill_in 'reward[description]', with: 'test reward description1'
    fill_in 'reward[price]', with: '0'
    click_button 'Create Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'
    fill_in 'reward[price]', with: '1'
    click_button 'Create Reward'
    expect(page).to have_content 'Reward was successfully created.'
    expect(page).to have_content 'test reward description1'
    expect(page).to have_content '1.0'

    click_link 'Edit'
    fill_in 'reward[title]', with: 'test reward title2'
    fill_in 'reward[description]', with: 'test reward description2'
    fill_in 'reward[price]', with: '2'
    click_button 'Update Reward'
    expect(page).to have_content 'test reward description2'
    expect(page).to have_content '2.0'
    expect(page).not_to have_content 'test reward description1'

    click_link 'Delete'
    expect(page).to have_content 'Reward was successfully destroyed.'
    expect(page).not_to have_content 'test reward description2'
  end
end
