require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  include Devise::Test::ControllerHelpers
  login_user
  render_views

  before do
    sign_in create :administrator
  end

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { FactoryBot.create(:user)  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      setting = FactoryBot.create(:setting)
      setting = create :setting
      get :show, params: {id: setting.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      setting = FactoryBot.create(:setting)
      get :edit, params: {id: setting.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Setting" do
        setting_attrs = attributes_for :setting
        expect {
          post :create, params: {setting: setting_attrs}
        }.to change(Setting, :count).by(1)
      end

      it "redirects to the created setting" do
        setting_attrs = attributes_for :setting
        post :create, params: {setting: setting_attrs}
        expect(response).to redirect_to(Setting.last)
      end
    end
  end 

  describe "DELETE #destroy" do
    it "destroys the requested setting" do
      setting = FactoryBot.create(:setting)
      expect {
        delete :destroy, params: {id: setting.to_param}
      }.to change(Setting, :count).by(-1)
    end

    it "redirects to the setting list" do
      setting = FactoryBot.create(:setting)
      delete :destroy, params: {id: setting.to_param}
      expect(response).to redirect_to(settings_url)
    end
  end

end
