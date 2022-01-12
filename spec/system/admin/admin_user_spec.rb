# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee) }
  let!(:employee2) { create(:employee) }
  let!(:admin_user) { create(:admin_user) }

  it 'test admin crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Admin Kudos'

    click_link 'New Kudo'
    fill_in 'Title', with: 'test title1'
    fill_in 'Content', with: 'test content1'
    select employee1.email, from: 'kudo[employee_id]'
    select employee1.email, from: 'kudo[receiver_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'test title1'
    expect(page).to have_content employee1.email

    click_link 'Edit'
    fill_in 'Title', with: 'test title2'
    select employee2.email, from: 'kudo[employee_id]'
    select employee2.email, from: 'kudo[receiver_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'test title2'
    expect(page).to have_content employee2.email
    expect(page).not_to have_content employee1.email
    click_link 'Back'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
    expect(page).not_to have_content 'test title2'
  end
end