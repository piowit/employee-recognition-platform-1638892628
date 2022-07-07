# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward categories', type: :system do
  let!(:admin) { create(:admin_user) }
  let(:category) { build(:category) }
  let!(:reward) { create(:reward) }

  it 'checks creating, editig, deleting reward categoires' do
    login_as admin, scope: :admin_user
    visit admin_root_path

    # create new category
    click_link 'Categories'
    click_link 'New Category'
    click_button 'Create Category'
    expect(page).to have_content 'Title can\'t be blank'
    fill_in 'category[title]', with: "test#{category.title}"
    click_button 'Create Category'
    expect(page).to have_content 'Category was successfully created.'
    expect(page).to have_content "test#{category.title}"

    # edit category
    click_link 'Categories'
    click_link 'Edit'
    fill_in 'category[title]', with: category.title
    click_button 'Update Category'
    expect(page).not_to have_content "test#{category.title}"
    expect(page).to have_content category.title

    # add reward to category
    click_link 'Rewards'
    click_link 'Edit'
    expect(page).to have_unchecked_field(category.title)
    check category.title
    click_button 'Update Reward'
    click_link 'Edit'
    expect(page).to have_checked_field(category.title)

    # try to destroy category that have reward in it
    click_link 'Categories'
    expect(page).to have_content category.title
    click_link 'Destroy'
    expect(page).to have_content 'Category must be empty in order to delete it.'

    # remove reward from category
    click_link 'Rewards'
    click_link 'Edit'
    uncheck category.title
    click_button 'Update Reward'
    click_link 'Edit'
    expect(page).to have_unchecked_field(category.title)

    # destroy empty category
    click_link 'Categories'
    expect(page).to have_content category.title
    click_link 'Destroy'
    expect(page).to have_content 'Category was successfully destroyed.'
  end
end
