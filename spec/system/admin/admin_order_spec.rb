# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  before do
    driven_by(:rack_test)
    Bullet.raise = false
  end

  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin_user) }
  let(:company_value) { create(:company_value) }
  let!(:reward1) { FactoryBot.create(:reward, price: 1) }
  let(:reward2) { FactoryBot.create(:reward, price: 2) }
  let!(:kudo) { create(:kudo, giver: employee, receiver: employee, company_value: company_value) }

  it 'tests placing order and snapshot' do
    login_as employee, scope: :employee
    login_as admin, scope: :admin_user

    # check if order list is not containg reward title
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).not_to have_content reward1.title

    # buy reward
    create(:order, employee_id: employee.id, reward: reward1, reward_snapshot: reward1)

    # check if reward was bought
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).to have_content reward1.title
    expect(page).to have_content employee.email

    # edit reward title with 'reward2'
    visit root_path
    click_link 'Admin'
    click_link 'Rewards'
    expect(page).to have_content reward1.title
    click_link 'Edit'
    fill_in 'reward[title]', with: reward2.title
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).to have_content reward2.title

    # check if reward snapshot has not change (reward =! reward snapshot)
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).to have_content reward1.title
    expect(page).not_to have_content reward2.title
  end
end
