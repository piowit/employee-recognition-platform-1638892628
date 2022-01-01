# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee2) { build(:employee, email: 'test2@test.com') }
  let(:employee3) { build(:employee, email: 'test3@test.com') }

  it 'Setup 2 employees and crud kudo' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: employee2.email
    fill_in 'Password', with: employee2.password
    fill_in 'Password confirmation', with: employee2.password
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    click_link 'Sign Out'
    expect(page).to have_content 'Log in'

    click_link 'Sign Up'
    fill_in 'Email', with: employee3.email
    fill_in 'Password', with: employee3.password
    fill_in 'Password confirmation', with: employee3.password
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'

    click_link 'New Kudo'
    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Content Test1'
    expect(page).to have_content 'test3@test.com'

    click_link 'Edit'
    fill_in 'Content', with: 'Another Content Test1'
    click_button 'Update Kudo'
    expect(page).to have_content 'Another Content Test1'

    # accept_confirm do
    click_link 'Destroy'
    # end
    expect(page).to have_content 'Kudo was successfully destroyed'
  end
end
