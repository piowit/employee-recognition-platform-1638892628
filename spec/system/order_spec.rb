# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order spec', type: :system do
  let!(:employee) { create(:employee) }
  let!(:reward_post) { create(:reward, price: 1, available_items: 1, delivery_method: 'post') }
  let!(:reward_online) { create(:reward, price: 1, delivery_method: 'online') }
  let!(:online_code) { create(:online_code, reward: reward_online) }
  let!(:company_value) { create(:company_value) }

  before do
    online_code
    create(:kudo, giver: employee, receiver: employee, company_value: company_value)
    login_as employee, scope: :employee
  end

  it 'tests online order' do
    visit orders_path
    expect(page).not_to have_content reward_online.title
    expect(page).not_to have_content reward_online.description
    expect(page).not_to have_content reward_online.price

    visit rewards_path
    expect(page).to have_content 'Received Points: 1'
    expect(page).to have_content reward_online.title
    reward_online_row = page.find("tr[data-reward-id=\"#{reward_online.id}\"]")
    reward_online_row.click_link 'Buy'
    expect(page).to have_content reward_online.title
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward_online.title
    expect(page).to have_content reward_online.description
    expect(page).to have_content reward_online.price

    visit rewards_path
    expect(page).not_to have_content reward_online.title
  end

  it 'tests post order with adding new address' do
    visit orders_path
    expect(page).not_to have_content reward_post.title
    expect(page).not_to have_content reward_post.description
    expect(page).not_to have_content reward_post.price

    visit rewards_path
    expect(page).to have_content 'Received Points: 1'
    expect(page).to have_content reward_post.title
    reward_post_row = page.find("tr[data-reward-id=\"#{reward_post.id}\"]")
    reward_post_row.click_link 'Buy'
    expect(page).to have_content reward_post.title
    fill_in 'order[address][street]', with: 'Odolanska 56'
    fill_in 'order[address][postcode]', with: '02-562'
    fill_in 'order[address][city]', with: 'Warszawa'
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward_post.title
    expect(page).to have_content reward_post.description
    expect(page).to have_content reward_post.price

    visit rewards_path
    expect(page).not_to have_content reward_post.title
  end
end
