require 'rails_helper'

RSpec.describe AwardsController, type: :controller do
  include Devise::Test::ControllerHelpers
  login_user
  render_views

  before do
    sign_in create :administrator
  end

  it 'should get "admin"' do
    get :admin
    expect(response).to be_successful
    expect(assigns :awards).not_to be_nil
  end

  it 'should get new' do
    get :new
    expect(response).to be_successful
  end

  it 'show post to create an award' do
    award_attrs = attributes_for :award
    expect{ post :create, params: { award: award_attrs }}.to change { Award.count }.by 1
    expect(response).to redirect_to award_path assigns :award
  end

  it 'should get to show an award' do
    award = create :award
    get :show, params: { id: award }
    expect(response).to be_successful
  end

  it 'should get to edit an award' do
    award = create :award
    get :edit, params: { id: award }
    expect(response).to be_successful
  end

  it 'should put to update an award' do
    today = Date.today
    award = create :award
    params = { id: award.id, award: { expiry_date: today }}
    expect(award.expiry_date).to be_nil
    expect{ patch :update, params: params }.to change{ award.reload.expiry_date }.from(nil).to(today)
    expect(response).to redirect_to award_path assigns :award
  end

  it 'should destroy award' do
    award = create :award
    expect{ delete :destroy, params: { id: award }}.to change{ Award.count }.by(-1)
    expect(response).to redirect_to awards_path
  end
end
