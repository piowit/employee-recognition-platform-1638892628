# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KudosController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/kudos').to route_to('kudos#index')
    end

    it 'routes to #new' do
      expect(get: '/kudos/new').to route_to('kudos#new')
    end

    it 'routes to #show' do
      expect(get: '/kudos/1').to route_to('kudos#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/kudos/1/edit').to route_to('kudos#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/kudos').to route_to('kudos#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/kudos/1').to route_to('kudos#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/kudos/1').to route_to('kudos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/kudos/1').to route_to('kudos#destroy', id: '1')
    end
  end
end
