# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo time permit test', type: :system do
  let!(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee) }
  let!(:kudo2) { create(:kudo, giver: employee) }

  context 'when we want to CRUD kudo' do
    before do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Kudos'
    end

    it 'edits/delete kudo before and after 5 minutes from creation' do
      # test kudo created just now
      tr1 = page.find("tr[data-kudo-id=\"#{kudo.id}\"]")
      expect(tr1).to have_content kudo.title
      tr1.click_link 'Edit'
      expect(page).to have_content 'Edit Kudo:'
      click_button 'Update Kudo'
      expect(page).to have_content 'Kudo was successfully updated.'
      click_link 'Destroy'
      expect(page).to have_content 'Kudo was successfully destroyed.'

      # test kudo after 6 minutes passes
      travel 6.minutes
      visit root_path
      click_link 'Kudos'
      tr2 = page.find("tr[data-kudo-id=\"#{kudo2.id}\"]")
      expect(tr2).not_to have_content 'Edit'
      expect(tr2).not_to have_content 'Destroy'
    end
  end
end
