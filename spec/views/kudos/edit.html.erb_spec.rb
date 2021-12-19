# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'kudos/edit', type: :view do
  before do
    @kudo = assign(:kudo, Kudo.create!(
                            title: 'MyString',
                            content: 'MyText',
                            employee: nil
                          ))
  end

  it 'renders the edit kudo form' do
    render

    assert_select 'form[action=?][method=?]', kudo_path(:kudo), 'post' do
      assert_select 'input[name=?]', 'kudo[title]'

      assert_select 'textarea[name=?]', 'kudo[content]'

      assert_select 'input[name=?]', 'kudo[employee_id]'
    end
  end
end
