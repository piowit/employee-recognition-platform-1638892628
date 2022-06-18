# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudos', type: :request do
  describe 'GET /kudos' do
    let!(:employee) { create(:employee) }

    before do
      Bullet.raise = false
      login_as employee, scope: :employee
    end

    it 'works!' do
      get kudos_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns kudos' do
      kud1 = create(:kudo)
      kud2 = create(:kudo)
      get kudos_path
      expect(response.body).to include kud1.title
      expect(response.body).to include kud2.title
    end
  end
end
