# frozen_string_literal: true

require 'rails_helper'
require 'tempfile'
require 'csv'

RSpec.describe 'Admin Panel for Manage Online Codes', type: :system do
  it 'adds correct unique code and show success message' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = build(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'Add Online Code'
    fill_in 'online_code[code]', with: online_code.code
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Online code was successfully added.'
    expect(page).to have_content online_code.code
  end

  it 'shows error when adding empty code' do
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'Add Online Code'
    click_button 'Create Online code'
    expect(page).to have_content "Code can't be blank"
  end

  it 'shows error when adding not unique code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'Add Online Code'
    fill_in 'online_code[code]', with: online_code.code
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Code has already been taken'
  end

  it 'edits exisitng code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    online_code_edited = build(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    expect(page).to have_content online_code.code
    click_link 'Edit'
    fill_in 'online_code[code]', with: online_code_edited.code
    click_button 'Update Online code'
    expect(page).to have_content 'Online code was successfully updated.'
    expect(page).not_to have_content online_code.code
    expect(page).to have_content online_code_edited.code
  end

  it 'destroys existing code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    expect(page).to have_content online_code.code
    click_link 'Destroy'
    expect(page).to have_content 'Online code was successfully destroyed.'
    expect(page).not_to have_content online_code.code
  end

  it 'exports csv with all online_codes fields' do
    admin = create(:admin_user)
    reward_online = create(:reward, delivery_method: 'online')
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
    admin = create(:admin_user)
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
    expect(page).to have_content '123-123' # this comes from spec/fixtures/online_codes.csv
    expect(page).to have_content '134-134'
    expect(page).to have_content '135-135'
  end
end
