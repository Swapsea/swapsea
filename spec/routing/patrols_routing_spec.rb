# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PatrolsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/patrols').to route_to('patrols#index')
    end

    it 'routes to #new' do
      expect(get: '/patrols/new').to route_to('patrols#new')
    end

    it 'routes to #show' do
      expect(get: '/patrols/1').to route_to('patrols#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/patrols/1/edit').to route_to('patrols#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/patrols').to route_to('patrols#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/patrols/1').to route_to('patrols#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/patrols/1').to route_to('patrols#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/patrols/1').to route_to('patrols#destroy', id: '1')
    end
  end
end
