# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OnlineCode, type: :model do
  it 'is valid with valid attributes' do
    online_code = build(:online_code)
    expect(online_code).to be_valid
  end

  it 'is not valid without codes' do
    online_code = build(:online_code, code: nil)
    expect(online_code).not_to be_valid
  end

  it 'is not valid w ith not unique code' do
    online_code = create(:online_code)
    not_unique_code = build(:online_code, code: online_code.code)
    expect(not_unique_code).not_to be_valid
  end

  it 'is not valid without reward' do
    online_code = build(:online_code, reward: nil)
    expect(online_code).not_to be_valid
  end

  it 'is valid without order' do
    online_code = build(:online_code, order: nil)
    expect(online_code).to be_valid
  end

  it 'is valid with order' do
    order = build(:order)
    online_code = build(:online_code, order: order)
    expect(online_code).to be_valid
  end
end
