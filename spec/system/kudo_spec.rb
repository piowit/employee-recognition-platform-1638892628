# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }

  it 'crud kudo' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'New Kudo'
    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Content Test1'

    click_link 'Edit'
    fill_in 'Content', with: 'Another Content Test1'
    click_button 'Update Kudo'
    expect(page).to have_content 'Another Content Test1'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed'
    expect(page).not_to have_content 'Another Content Test1'
  end
end
