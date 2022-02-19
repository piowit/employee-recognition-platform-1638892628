# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order delivery filter', type: :system do
  let!(:employee) { create(:employee) }
  let!(:order_delivered) { create(:order, employee: employee, delivered: true) }
  let!(:order_notdelivered) { create(:order, employee: employee, delivered: false) }

  context 'when we want to filter orders' do
    before do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Orders'
    end

    it 'displays default all filter' do
      expect(page).to have_content order_delivered.reward.title
      expect(page).to have_content order_notdelivered.reward.title
    end

    it 'displays only delivered filter' do
      click_link 'Delivered'
      expect(page).to have_content order_delivered.reward.title
      expect(page).not_to have_content order_notdelivered.reward.title
    end

    it 'displays only not delivered filter' do
      click_link 'Not Delivered'
      expect(page).not_to have_content order_delivered.reward.title
      expect(page).to have_content order_notdelivered.reward.title
    end

    it 'displays all filter' do
      click_link 'All'
      expect(page).to have_content order_delivered.reward.title
      expect(page).to have_content order_notdelivered.reward.title
    end
  end
end
