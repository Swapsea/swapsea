# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/offers').to route_to('offers#index')
    end

    it 'routes to #new' do
      expect(get: '/offers/new').to route_to('offers#new')
    end

    it 'routes to #show' do
      expect(get: '/offers/1').to route_to('offers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/offers/1/edit').to route_to('offers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/offers').to route_to('offers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/offers/1').to route_to('offers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/offers/1').to route_to('offers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/offers/1').to route_to('offers#destroy', id: '1')
    end

    it 'routes to #accept' do
      expect(get: '/offers/1/accept').to route_to('offers#accept', id: '1')
    end

    it 'routes to #decline' do
      expect(get: '/offers/1/decline').to route_to('offers#decline', id: '1')
    end

    it 'routes to #confirm_accept' do
      expect(get: '/offers/1/confirm-accept').to route_to('offers#confirm_accept', id: '1')
    end

    it 'routes to #confirm_decline' do
      expect(get: '/offers/1/confirm-decline').to route_to('offers#confirm_decline', id: '1')
    end

    it 'routes to #confirm_cancel' do
      expect(get: '/offers/1/confirm-cancel').to route_to('offers#confirm_cancel', id: '1')
    end
  end
end
