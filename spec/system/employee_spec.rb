# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee account test', type: :system do
  it 'create user, sign up, log out, log in' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First name', with: 'Piotr'
    fill_in 'Last name', with: 'Witek'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'testpassword'
    fill_in 'Password confirmation', with: 'testpassword'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'Available Kudos: 10'
    click_link 'Log Out'
    click_link 'Log In'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
