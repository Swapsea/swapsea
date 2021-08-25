# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'Forbidden areas' do
    it 'authorization failure' do
      get '/403'
      expect(response).to have_http_status(:forbidden)
    end

    # TODO: Should be moved to Admin spec
    it 'protected resources' do
      get '/admin'
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end

  it 'resource not found' do
    expect { get '/not-found' }
      .to raise_error(ActionController::RoutingError)
  end

  it 'record not found' do
    expect { get '/users/0' }
      .to raise_error(ActiveRecord::RecordNotFound)
  end
end
