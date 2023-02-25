# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventLogsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/event_logs').to route_to('event_logs#index')
    end

    it 'routes to #new' do
      expect(get: '/event_logs/new').to route_to('event_logs#new')
    end

    it 'routes to #show' do
      expect(get: '/event_logs/1').to route_to('event_logs#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/event_logs/1/edit').to route_to('event_logs#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/event_logs').to route_to('event_logs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/event_logs/1').to route_to('event_logs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/event_logs/1').to route_to('event_logs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/event_logs/1').to route_to('event_logs#destroy', id: '1')
    end
  end
end
