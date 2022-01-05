# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUser test', type: :system do
  before do
    driven_by(:rack_test)
  end
  
  let!(:admin_user) { create(:admin_user) }

  it 'admin log in' do
    visit root_path
    click_link 'Log In Admin'
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Welcome in dashboard'
  end
end
