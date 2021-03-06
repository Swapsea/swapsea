require 'rails_helper'

RSpec.describe LeadsController, type: :controller do
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

  describe "GET #admin" do
    it "returns a success response" do
      get :admin
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      lead = FactoryBot.create(:lead)
      lead = create :lead
      get :show, params: {id: lead.to_param}
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
      lead = FactoryBot.create(:lead)
      get :edit, params: {id: lead.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Lead" do
        lead_attrs = attributes_for :lead
        expect {
          post :create, params: {lead: lead_attrs}
        }.to change(Lead, :count).by(1)
      end

      it "redirects to the created lead" do
        lead_attrs = attributes_for :lead
        post :create, params: {lead: lead_attrs}
        expect(response).to redirect_to(thanks_path)
      end
    end
  end 

  describe "DELETE #destroy" do
    it "destroys the requested lead" do
      lead = FactoryBot.create(:lead)
      expect {
        delete :destroy, params: {id: lead.to_param}
      }.to change(Lead, :count).by(-1)
    end

    it "redirects to the leads list" do
      lead = FactoryBot.create(:lead)
      delete :destroy, params: {id: lead.to_param}
      expect(response).to redirect_to(leads_url)
    end
  end

end
