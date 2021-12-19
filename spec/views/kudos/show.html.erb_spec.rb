# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'kudos/show', type: :view do
  before do
    @kudo = assign(:kudo, Kudo.create!(
                            title: 'Title',
                            content: 'MyText',
                            employee: nil
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
