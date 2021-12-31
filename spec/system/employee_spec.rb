# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee test' do
  let(:employee1) { build(:employee) }

  it 'Setup employee acc' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: employee1.email
    fill_in 'Password', with: employee1.password
    fill_in 'Password confirmation', with: employee1.password
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'

    click_link 'Sign Out'
    expect(page).to have_content 'Log in'

    click_link 'Sign In'
    fill_in 'Email', with: employee1.email
    fill_in 'Password', with: employee1.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
