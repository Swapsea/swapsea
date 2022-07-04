# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProficiencySignupsController, type: :controller do
  include Devise::Test::ControllerHelpers
  login_user
  render_views

  before do
    sign_in create :admin
  end

  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { FactoryBot.create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      proficiency_signup = FactoryBot.create(:proficiency_signup)
      proficiency_signup = create :proficiency_signup
      get :show, params: { id: proficiency_signup.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      proficiency_signup = FactoryBot.create(:proficiency_signup)
      get :edit, params: { id: proficiency_signup.to_param }
      expect(response).to be_successful
    end
  end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new proficiency_signup" do
  #       proficiency_signup_attrs = attributes_for :proficiency_signup
  #       expect {
  #         post :create, params: {proficiency_signup: proficiency_signup_attrs}
  #       }.to change(ProficiencySignup, :count).by(1)
  #     end

  #     it "redirects to the created lead" do
  #       proficiency_signup_attrs = attributes_for :proficiency_signup
  #       post :create, params: {proficiency_signup: proficiency_signup_attrs}
  #       expect(response).to redirect_to(proficiencies_path)
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    it 'destroys the requested proficiency_signup' do
      proficiency_signup = FactoryBot.create(:proficiency_signup)
      expect do
        delete :destroy, params: { id: proficiency_signup.to_param }
      end.to change(ProficiencySignup, :count).by(-1)
    end

    it 'redirects to the proficiency_signups list' do
      proficiency_signup = FactoryBot.create(:proficiency_signup)
      delete :destroy, params: { id: proficiency_signup.to_param }
      expect(response).to redirect_to(proficiencies_path)
    end
  end
end
