require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers
  login_user
  render_views

  before do
    sign_in create :administrator
  end

  let(:valid_attributes) {
    skip('Add a hash of attributes valid for your model')
  }

  let(:invalid_attributes) {
    skip('Add a hash of attributes invalid for your model')
  }

  let(:valid_session) { FactoryBot.create(:user)  }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end


end
