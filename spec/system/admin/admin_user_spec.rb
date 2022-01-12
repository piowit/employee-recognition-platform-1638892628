# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
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
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'test title1'

    click_link 'Edit'
    fill_in 'Title', with: 'test title2'
    click_button 'Update Kudo'
    expect(page).to have_content 'test title2'
    click_link 'Back'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
    expect(page).not_to have_content 'test title2'
  end
end
