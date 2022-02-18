# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  before do
    driven_by(:rack_test)
    Bullet.raise = false
  end

  let!(:admin) { create(:admin_user) }
  let!(:order) { create(:order) }

  it 'tests delivering order' do
    # login_as employee, scope: :employee
    login_as admin, scope: :admin_user

    # check if order is not delivered
    visit root_path
    click_link 'Admin'
    click_link 'Orders'
    expect(page).to have_content 'Not yet'

    # deliver order
    click_link 'Deliver'
    expect(page).to have_content 'Order delivered'
    expect(page).to have_content 'Delivered'

    # check if you can deliver again
    visit deliver_admin_order_path(order)
    expect(page).to have_content 'Order already delivered'
  end
end
