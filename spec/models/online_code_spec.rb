# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OnlineCode, type: :model do
  let(:online_code) { create(:online_code) }

  it 'is valid with valid attributes' do
    expect(online_code).to be_valid
  end

  it 'is not valid without codes' do
    online_code.code = nil
    expect(online_code).not_to be_valid
  end

  it 'is not valid w ith not unique code' do
    not_unique_code = build(:online_code, code: online_code.code, reward_id: online_code.reward_id)
    expect(not_unique_code).not_to be_valid
  end

  it 'is not valid without reward' do
    online_code.reward = nil
    expect(online_code).not_to be_valid
  end

  it 'is valid without order' do
    online_code.order = nil
    expect(online_code).to be_valid
  end

  it 'is valid with order' do
    order = create(:order)
    online_code.order = order
    expect(online_code).to be_valid
  end
end
