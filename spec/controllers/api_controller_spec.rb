require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  login_user

  # describe "GET #import_members" do
  #   it "returns http success" do
  #     get :import_members
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #import_awards" do
  #   it "returns http success" do
  #     get :import_awards
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #import_patrol_members" do
  #   it "returns http success" do
  #     get :import_patrol_members
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #import_rosters" do
  #   it "returns http success" do
  #     get :import_rosters
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  let(:file_data) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/file.csv'))) }

  describe 'POST #upload_members' do
    it 'returns http success' do
      post :upload_members, params: { file_data: file_data }
    end
  end

  describe 'POST #upload_awards' do
    it 'returns http success' do
      post :upload_awards, params: { file_data: file_data }
    end
  end

   describe 'POST #upload_patrol_members' do
    it 'returns http success' do
      post :upload_patrol_members, params: { file_data: file_data }
    end
  end

end
