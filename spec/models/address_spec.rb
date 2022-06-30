# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { create(:address) }

  it 'is valid with valid attributes' do
    expect(address).to be_valid
  end

  it 'is not valid without street' do
    address.street = nil
    expect(address).not_to be_valid
  end

  it 'is not vaild without postcode' do
    address.postcode = nil
    expect(address).not_to be_valid
  end

  it 'is not vaild without city' do
    address.city = nil
    expect(address).not_to be_valid
  end

  it 'is not vaild without employee' do
    address.employee = nil
    expect(address).not_to be_valid
  end
end
