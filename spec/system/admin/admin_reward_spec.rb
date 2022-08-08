# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin crud', type: :system do
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

  it 'imports rewards in csv format' do
    visit admin_root_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Rewards'

    click_button 'Import CSV'
    expect(page).to have_content 'No file selected.'

    attach_file 'file', 'spec/factories/online_codes.rb'
    click_button 'Import CSV'
    expect(page).to have_content 'File is not a ".csv"'

    attach_file 'file', 'spec/fixtures/rewards.csv'
    click_button 'Import CSV'
    expect(page).to have_content 'Reward 1' # this comes from spec/fixtures/online_codes.csv
    expect(page).to have_content 'Reward 2'
    expect(page).to have_content 'Reward 3'
    expect(page).not_to have_content 'No slug reward'
  end

  it 'exports csv with all rewards fields' do
    admin = create(:admin_user)
    reward = create(:reward)
    login_as admin, scope: :admin_user
    visit root_path
    click_link 'Admin'
    click_link 'Rewards'
    click_on 'Download all rewards as CSV'

    csv = CSV.new(page.body).read

    expect(csv).to have_content reward.slug
    expect(csv).to have_content reward.title
    expect(csv).to have_content reward.description
    expect(csv).to have_content reward.price
    expect(csv).to have_content reward.delivery_method
  end
end
