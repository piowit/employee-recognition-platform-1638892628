# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'order delivery filter spec', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:order_delivered) { create(:order, employee: employee, delivered: true) }
  let!(:order_notdelivered) { create(:order, employee: employee, delivered: false) }

  it 'checks delivered and not delivered filter' do
    login_as employee, scope: :employee

    visit root_path
    click_link 'Orders'
    expect(page).to have_content order_delivered.reward.title
    expect(page).to have_content order_notdelivered.reward.title

    click_link 'Delivered'
    expect(page).to have_content order_delivered.reward.title
    expect(page).not_to have_content order_notdelivered.reward.title

    click_link 'Not Delivered'
    expect(page).not_to have_content order_delivered.reward.title
    expect(page).to have_content order_notdelivered.reward.title

    click_link 'All'
    expect(page).to have_content order_delivered.reward.title
    expect(page).to have_content order_notdelivered.reward.title
  end
end
