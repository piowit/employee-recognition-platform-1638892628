# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  before do
    driven_by(:rack_test)
    Bullet.raise = false
  end

  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin_user) }
  let!(:kudo) { create(:kudo, giver: employee, receiver: employee) }

  it 'tests placing order and snapshot' do
    login_as employee, scope: :employee
    login_as admin, scope: :admin_user

    # check if order list is not containg reward title
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).not_to have_content 'Edit'

    # buy reward
    order = create(:order, employee: employee)

    # check if reward was bought
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.employee.full_name

    # edit reward title with 'reward2reward2'
    visit root_path
    click_link 'Admin'
    click_link 'Rewards'
    expect(page).to have_content order.reward.title
    click_link 'Edit'
    fill_in 'reward[title]', with: 'reward2reward2'
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).to have_content 'reward2reward2'

    # check if reward snapshot has not change (reward =! reward snapshot)
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).to have_content order.reward.title
    expect(page).not_to have_content 'reward2reward2'
  end
end
