# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Adding Kudos to every employee', type: :system do
  let!(:employee1) { create(:employee, number_of_available_kudos: 11) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 22) }
  let!(:employee3) { create(:employee, number_of_available_kudos: 33) }
  let!(:admin) { create(:admin_user) }

  number = rand(20)
  wrong_number = rand(21..100)

  it 'tests adding kudos to employees' do
    login_as admin, scope: :admin_user
    visit admin_root_path
    click_link 'Add Kudos'
    tr1 = page.find("tr[data-user-email=\"#{employee1.email}\"]")
    tr2 = page.find("tr[data-user-email=\"#{employee2.email}\"]")
    tr3 = page.find("tr[data-user-email=\"#{employee3.email}\"]")
    expect(tr1).to have_content employee1.number_of_available_kudos
    expect(tr2).to have_content employee2.number_of_available_kudos
    expect(tr3).to have_content employee3.number_of_available_kudos

    fill_in 'employee_amount', with: number
    click_button 'Add points'
    expect(page).to have_content "Added #{number} points to every employee"
    expect(tr1).to have_content employee1.reload.number_of_available_kudos
    expect(tr2).to have_content employee2.reload.number_of_available_kudos
    expect(tr3).to have_content employee3.reload.number_of_available_kudos

    fill_in 'employee_amount', with: wrong_number
    click_button 'Add points'
    expect(page).to have_content 'Number must be between 1 and 20'
  end
end
