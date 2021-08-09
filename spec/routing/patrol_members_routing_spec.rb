# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PatrolMembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/patrol_members').to route_to('patrol_members#index')
    end

    it 'routes to #new' do
      expect(:get => '/patrol_members/new').to route_to('patrol_members#new')
    end

    it 'routes to #show' do
      expect(:get => '/patrol_members/1').to route_to('patrol_members#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/patrol_members/1/edit').to route_to('patrol_members#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/patrol_members').to route_to('patrol_members#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/patrol_members/1').to route_to('patrol_members#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/patrol_members/1').to route_to('patrol_members#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/patrol_members/1').to route_to('patrol_members#destroy', :id => '1')
    end

    it 'routes to #import' do
      expect(:post => '/patrol_members/import').to route_to('patrol_members#import')
    end
  end
end
