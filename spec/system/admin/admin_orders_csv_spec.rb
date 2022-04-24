# frozen_string_literal: true

require 'rails_helper'
require 'tempfile'

RSpec.describe 'Admin orders export csv' do
  let!(:admin) { create(:admin_user) }
  let!(:order1) { create(:order) }
  let!(:order2) { create(:order) }

  before do
    login_as admin, scope: :admin_user
    visit root_path
  end

  it 'exports csv with all order fields' do
    click_link 'Admin'
    click_link 'Orders'
    click_on 'Download all orders as CSV'

    # write new Tempfile
    file = Tempfile.new
    file.write(page.body)
    file.rewind
    csv = file.read
    file.close
    file.unlink

    expect(csv).to have_content order1.reward_snapshot.title
    expect(csv).to have_content order1.reward_snapshot.description
    expect(csv).to have_content order1.reward_snapshot.price
    expect(csv).to have_content order2.reward_snapshot.title
    expect(csv).to have_content order2.reward_snapshot.description
    expect(csv).to have_content order2.reward_snapshot.price
  end
end
