# frozen_string_literal: true

require 'test_helper'

class OutreachPatrolsControllerTest < ActionController::TestCase
  before do
    @outreach_patrol = outreach_patrols(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:outreach_patrols)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create outreach_patrol' do
    assert_difference('OutreachPatrol.count') do
      post :create,
           params: { outreach_patrol: { finish: @outreach_patrol.finish, location: @outreach_patrol.location,
                                        start: @outreach_patrol.start } }
    end

    assert_redirected_to outreach_patrol_path(assigns(:outreach_patrol))
  end

  test 'should show outreach_patrol' do
    get :show, params: { id: @outreach_patrol }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @outreach_patrol }
    assert_response :success
  end

  test 'should update outreach_patrol' do
    patch :update,
          params: { id: @outreach_patrol,
                    outreach_patrol: { finish: @outreach_patrol.finish, location: @outreach_patrol.location,
                                       start: @outreach_patrol.start } }
    assert_redirected_to outreach_patrol_path(assigns(:outreach_patrol))
  end

  test 'should destroy outreach_patrol' do
    assert_difference('OutreachPatrol.count', -1) do
      delete :destroy, params: { id: @outreach_patrol }
    end

    assert_redirected_to outreach_patrols_path
  end
end
