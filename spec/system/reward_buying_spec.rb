# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward buying', type: :system do
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }

  context 'when we want to buy reward' do
    before do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Rewards'
    end

    it 'checks if reward exist' do
      click_link 'Rewards'
      expect(page).to have_content reward.title
      expect(page).to have_content reward.price
      expect(page).to have_content 'Received Points: 0'
    end

    it 'checks reward show page' do
      click_link 'Show'
      expect(page).to have_content reward.title
      expect(page).to have_content reward.description
      expect(page).to have_content reward.price
    end

    it 'try to buy reward, while not having funds' do
      click_link 'Buy'
      expect(page).to have_content 'You have insufficient funds'
    end

    it 'buys reward with funds' do
      create(:kudo, receiver: employee)
      click_link 'Rewards'
      expect(page).to have_content 'Received Points: 1'
      click_link 'Buy'
      expect(page).to have_content 'Reward bought'
      expect(page).to have_content 'Received Points: 0'
    end
  end
end
