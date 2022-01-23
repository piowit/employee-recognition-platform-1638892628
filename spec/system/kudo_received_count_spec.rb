# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:company_value) { create(:company_value) }

  it 'test received kudos count' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Received Kudos: 0'

    create(:kudo, receiver_of_kudo: employee, giver_of_kudo: employee, company_value: company_value)
    
    visit kudos_path
    expect(page).to have_content 'Received Kudos: 1'
   
  end
end
