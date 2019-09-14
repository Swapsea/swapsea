require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "GET #import_members" do
    it "returns http success" do
      get :import_members
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #import_awards" do
    it "returns http success" do
      get :import_awards
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #import_patrol_members" do
    it "returns http success" do
      get :import_patrol_members
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #import_rosters" do
    it "returns http success" do
      get :import_rosters
      expect(response).to have_http_status(:success)
    end
  end

end
