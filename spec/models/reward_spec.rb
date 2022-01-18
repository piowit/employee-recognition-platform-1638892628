# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reward, type: :model do
  subject(:reward) { described_class.new(title: 'test', description: 'test', price: 1) }

  it 'is valid with valid attributes' do
    expect(reward).to be_valid
  end

  it 'is not valid without a title' do
    reward.title = nil
    expect(reward).not_to be_valid
  end

  it 'is not valid without a description' do
    reward.description = nil
    expect(reward).not_to be_valid
  end

  it 'is not valid without a price' do
    reward.price = nil
    expect(reward).not_to be_valid
  end

  it 'is not valid with price lower than 0' do
    reward.price = -1
    expect(reward).not_to be_valid
  end

  it 'is not valid with price equal 0' do
    reward.price = 0
    expect(reward).not_to be_valid
  end
end
