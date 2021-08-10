# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwapsController, type: :controller do
  include Devise::Test::ControllerHelpers
  login_user
  render_views

  before do
    sign_in create :administrator
  end

  # This should return the minimal set of attributes required to create a valid
  # EventLog. As you add validations to EventLog, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventLogsController. Be sure to keep this updated too.
  let(:valid_session) { FactoryBot.create(:user) }

  before do
    sign_in create :administrator
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #my_offers' do
    it 'returns a success response' do
      get :my_offers
      expect(response).to be_successful
    end
  end

  describe 'GET #my_requests' do
    it 'returns a success response' do
      get :my_requests
      expect(response).to be_successful
    end
  end

  describe 'GET #confirmed' do
    it 'returns a success response' do
      get :confirmed
      expect(response).to be_successful
    end
  end
end
