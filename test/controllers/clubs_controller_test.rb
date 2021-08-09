# frozen_string_literal: true
require 'test_helper'

class ClubsControllerTest < ActionController::TestCase
  setup do
    @club = clubs(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:clubs)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club' do
    assert_difference('Club.count') do
      post :create, params: { club: { name: @club.name, outreach: @club.outreach, patrols: @club.patrols, rosters: @club.rosters, secret: @club.secret, short_name: @club.short_name, skills_maintenance: @club.skills_maintenance, swaps: @club.swaps } }
    end

    assert_redirected_to club_path(assigns(:club))
  end

  test 'should show club' do
    get :show, params: { id: @club }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club }
    assert_response :success
  end

  test 'should update club' do
    patch :update, params: { id: @club, club: { name: @club.name, outreach: @club.outreach, patrols: @club.patrols, rosters: @club.rosters, secret: @club.secret, short_name: @club.short_name, skills_maintenance: @club.skills_maintenance, swaps: @club.swaps } }
    assert_redirected_to club_path(assigns(:club))
  end

  test 'should destroy club' do
    assert_difference('Club.count', -1) do
      delete :destroy, params: { id: @club }
    end

    assert_redirected_to clubs_path
  end
end
