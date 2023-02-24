# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProficienciesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/proficiencies').to route_to('proficiencies#index')
    end

    it 'routes to #new' do
      expect(get: '/proficiencies/new').to route_to('proficiencies#new')
    end

    it 'routes to #show' do
      expect(get: '/proficiencies/1').to route_to('proficiencies#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/proficiencies/1/edit').to route_to('proficiencies#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/proficiencies').to route_to('proficiencies#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/proficiencies/1').to route_to('proficiencies#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/proficiencies/1').to route_to('proficiencies#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/proficiencies/1').to route_to('proficiencies#destroy', id: '1')
    end

    it 'routes to #skills-maintenance' do
      expect(get: '/skills-maintenance').to route_to('proficiencies#index')
    end
  end
end
