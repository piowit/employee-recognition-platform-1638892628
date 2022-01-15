# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }

  it 'test admin crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    click_link 'Admin Company Values'

    click_link 'Add Company Value'
    fill_in 'company_value[title]', with: 'test cv title1'
    click_button 'Create Company value'
    expect(page).to have_content 'Company Value was successfully created.'
    expect(page).to have_content 'test cv title1'

    click_link 'Edit'
    fill_in 'company_value[title]', with: 'test cv title2'
    click_button 'Update Company value'
    expect(page).to have_content 'test cv title2'
    expect(page).not_to have_content 'test cv title1'

    click_link 'Delete'
    expect(page).to have_content 'Company Value was successfully destroyed.'
    expect(page).not_to have_content 'test cv title2'
  end
end
