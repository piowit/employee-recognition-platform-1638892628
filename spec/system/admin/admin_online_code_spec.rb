# frozen_string_literal: true

require 'rails_helper'
require 'tempfile'
require 'csv'

RSpec.describe 'Online Code spec', type: :system do
  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin_user) }
  let!(:reward_online) { create(:reward, delivery_method: 'online') }
  let!(:reward_post) { create(:reward, delivery_method: 'post') }

  it 'crud online code for online reward' do
    login_as admin, scope: :admin_user
    visit root_path
    click_link 'Admin'
    click_link 'Online Codes'

    # add empty code
    click_link 'Add Online Code'
    click_button 'Create Online code'
    expect(page).to have_content "Code can't be blank"

    # add unique code
    fill_in 'online_code[code]', with: '123-123'
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Online code was successfully added.'
    expect(page).to have_content '123-123'

    # add not-unique code
    click_link 'Add Online Code'
    fill_in 'online_code[code]', with: '123-123'
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Code has already been taken'

    # edit code
    click_link 'Online Codes'
    click_link 'Edit'
    fill_in 'online_code[code]', with: '333-333'
    click_button 'Update Online code'
    expect(page).to have_content 'Online code was successfully updated.'
    expect(page).not_to have_content '123-123'
    expect(page).to have_content '333-333'

    # destroy code
    click_link 'Online Codes'
    click_link 'Destroy'
    expect(page).to have_content 'Online code was successfully destroyed.'
    expect(page).not_to have_content '333-333'
  end

  it 'exports csv with all online_codes fields' do
    online_code = create(:online_code, reward: reward_online)
    login_as admin, scope: :admin_user
    visit root_path
    click_link 'Admin'
    click_link 'Online Codes'
    click_on 'Download Online Codes as CSV'

    csv = CSV.new(page.body).read

    expect(csv).to have_content reward_online.slug
    expect(csv).to have_content online_code.code
  end

  it 'imports a csv file' do
    login_as admin, scope: :admin_user
    create(:reward, title: 'test', slug: 'test')
    visit admin_online_codes_path
    click_button 'Import Online Codes'
    expect(page).to have_content 'No file selected.'

    attach_file 'file', 'spec/factories/online_codes.rb'
    click_button 'Import Online Codes'
    expect(page).to have_content 'File is not a ".csv"'

    attach_file 'file', 'spec/fixtures/online_codes.csv'
    click_button 'Import Online Codes'
    visit admin_online_codes_path
    expect(page).to have_content '123-123'
    expect(page).to have_content '134-134'
    expect(page).to have_content '135-135'
  end
end
