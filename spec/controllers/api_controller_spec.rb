require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  login_user
  describe "GET #upload_members" do
    it "returns http success" do
      get :upload_members
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #upload_awards" do
    it "returns http success" do
      get :upload_awards
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #upload_patrol_members" do
    it "returns http success" do
      get :upload_patrol_members
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET #import_rosters" do
  #   it "returns http success" do
  #     get :import_rosters
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
