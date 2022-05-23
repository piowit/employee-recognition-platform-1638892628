# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::EmployeeControler', type: :system do
  let!(:admin) { create(:admin_user) }
  let!(:employee1) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee1) }
  let!(:order) { create(:order, employee: employee1) }

  it 'deletes employee with kudos and order' do
    login_as admin, scope: :admin_user

    visit root_path
    click_link 'Admin'
    click_link 'Employees'
    tr = page.find("tr[data-user-email=\"#{employee1.email}\"]")
    expect(tr).to have_content employee1.first_name
    tr.click_link 'Destroy'
    expect(page).to have_content 'Employee was successfully destroyed.'
    expect(page).not_to have_content employee1.first_name
  end

  it 'edit employee name' do
    login_as admin, scope: :admin_user

    visit root_path
    click_link 'Admin'
    click_link 'Employees'
    tr = page.find("tr[data-user-email=\"#{employee1.email}\"]")
    expect(tr).to have_content employee1.first_name
    expect(tr).to have_content employee1.last_name
    tr.click_link 'Edit'
    fill_in 'employee[first_name]', with: 'Test-Name'
    fill_in 'employee[last_name]', with: 'Test-Last-Name'
    click_button 'Update'
    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).not_to have_content employee1.first_name
    expect(page).not_to have_content employee1.last_name
    expect(page).to have_content 'Test-Name'
    expect(page).to have_content 'Test-Last-Name'
  end
end
