# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }

  it 'crud kudo' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Received Points: 0'

    click_link 'New Kudo'
    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    select employee.email, from: 'kudo[receiver_id]'
    select company_value1.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Content Test1'
    expect(page).to have_content company_value1.title
    expect(page).to have_content 'Received Points: 1'

    click_link 'Edit'
    fill_in 'Content', with: 'Another Content Test1'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Another Content Test1'
    expect(page).to have_content company_value2.title

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed'
    expect(page).not_to have_content 'Another Content Test1'
    expect(page).to have_content 'Received Points: 0'
  end
end
