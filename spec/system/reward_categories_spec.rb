# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward categories', type: :system do
  let!(:cat_rew1) { create(:category_reward) }
  let!(:cat_rew2) { create(:category_reward) }
  let!(:employee) { create(:employee) }

  before do
    login_as employee, scope: :employee
    visit root_path
    click_link 'Rewards'
  end

  context 'when visiting rewards index page without a category selected' do
    it 'displays all category buttons' do
      expect(page).to have_content cat_rew1.category.title
      expect(page).to have_content cat_rew2.category.title
    end

    it 'displays all rewards' do
      expect(page).to have_content cat_rew1.reward.title
      expect(page).to have_content cat_rew2.reward.title
    end

    context 'when a category is selected' do
      it 'displays only categorized rewards' do
        # checking filter 1
        click_link cat_rew1.category.title
        expect(page).to have_content cat_rew1.reward.title
        expect(page).not_to have_content cat_rew2.reward.title

        # checking filter 2
        click_link cat_rew2.category.title
        expect(page).not_to have_content cat_rew1.reward.title
        expect(page).to have_content cat_rew2.reward.title

        # checking default All filter
        click_link 'All'
        expect(page).to have_content cat_rew1.reward.title
        expect(page).to have_content cat_rew2.reward.title
      end
    end
  end
end
