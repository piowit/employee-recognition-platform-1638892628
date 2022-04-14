# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward categories', type: :system do
  let!(:cat_rew1) { create(:category_reward) }
  let!(:cat_rew2) { create(:category_reward) }
  let!(:cat_rew3) { create(:category_reward) }
  let!(:cat_rew4) { create(:category_reward) }
  let!(:employee) { create(:employee) }

  context 'when we want to check reward categories' do
    before do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Rewards'
    end

    it 'checks if category buttons exist' do
      expect(page).to have_content cat_rew1.category.title
      expect(page).to have_content cat_rew2.category.title
      expect(page).to have_content cat_rew3.category.title
      expect(page).to have_content cat_rew4.category.title
      expect(page).to have_content cat_rew1.reward.title
      expect(page).to have_content cat_rew2.reward.title
      expect(page).to have_content cat_rew3.reward.title
      expect(page).to have_content cat_rew4.reward.title
    end

    it 'checks if default all rewards visible' do
      expect(page).to have_content cat_rew1.reward.title
      expect(page).to have_content cat_rew2.reward.title
      expect(page).to have_content cat_rew3.reward.title
      expect(page).to have_content cat_rew4.reward.title
    end

    it 'checks filtered rewards' do
      # checking filter 1
      click_link cat_rew1.category.title
      expect(page).to have_content cat_rew1.reward.title
      expect(page).not_to have_content cat_rew2.reward.title
      expect(page).not_to have_content cat_rew3.reward.title
      expect(page).not_to have_content cat_rew4.reward.title

      # checking filter 4
      click_link cat_rew4.category.title
      expect(page).not_to have_content cat_rew1.reward.title
      expect(page).not_to have_content cat_rew2.reward.title
      expect(page).not_to have_content cat_rew3.reward.title
      expect(page).to have_content cat_rew4.reward.title

      # checking default All filter
      click_link 'All'
      expect(page).to have_content cat_rew1.reward.title
      expect(page).to have_content cat_rew2.reward.title
      expect(page).to have_content cat_rew3.reward.title
      expect(page).to have_content cat_rew4.reward.title
    end
  end
end
