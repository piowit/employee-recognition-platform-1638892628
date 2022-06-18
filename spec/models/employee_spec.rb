# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create(:employee) }

  it 'is valid with valid attributes' do
    expect(employee).to be_valid
  end

  it 'is not valid without first_name' do
    employee.first_name = nil
    expect(employee).not_to be_valid
  end

  it 'is not vaild without last_name' do
    employee.last_name = nil
    expect(employee).not_to be_valid
  end

  it 'is not vaild without email' do
    employee.email = nil
    expect(employee).not_to be_valid
  end
end
