# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OutreachPatrolsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/outreach_patrols').to route_to('outreach_patrols#index')
    end

    it 'routes to #new' do
      expect(get: '/outreach_patrols/new').to route_to('outreach_patrols#new')
    end

    it 'routes to #show' do
      expect(get: '/outreach_patrols/1').to route_to('outreach_patrols#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/outreach_patrols/1/edit').to route_to('outreach_patrols#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/outreach_patrols').to route_to('outreach_patrols#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/outreach_patrols/1').to route_to('outreach_patrols#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/outreach_patrols/1').to route_to('outreach_patrols#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/outreach_patrols/1').to route_to('outreach_patrols#destroy', id: '1')
    end

    it 'routes to #admin' do
      expect(get: '/outreach_patrols/admin').to route_to('outreach_patrols#admin')
    end
  end
end
