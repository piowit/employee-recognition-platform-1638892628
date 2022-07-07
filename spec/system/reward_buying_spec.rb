# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward buying', type: :system do
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }
  let!(:online_code) { create(:online_code, reward: reward) }

  context 'when we want to buy reward' do
    before do
      online_code
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
      expect(page).to have_content reward.title
      click_button 'Buy'
      expect(page).to have_content 'Reward bought'
      expect(page).to have_content 'Received Points: 0'
    end
  end

  context 'when want to view available rewards' do
    before do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Rewards'
    end

    it 'paginates rewards' do
      create_list(:reward, 25, delivery_method: 'post', available_items: 1)
      click_link 'Rewards'
      within('#rewards_table') do
        expect(all('tr').count).to eq(11)
      end
      expect(page).to have_link '3'
      expect(page).not_to have_link '4'
      click_link '3'
      expect(page).to have_content 'Page 3'
      expect(page).to have_content Reward.order(:title).last.title
      expect(page).not_to have_content Reward.order(:title).first.title
      click_link '2'
      expect(page).to have_content 'Page 2'
      expect(page).not_to have_content Reward.order(:title).last.title
      expect(page).not_to have_content Reward.order(:title).first.title
      click_link '1'
      expect(page).to have_content 'Page 1'
      expect(page).not_to have_content Reward.order(:title).last.title
      expect(page).to have_content Reward.order(:title).first.title
    end
  end
end
