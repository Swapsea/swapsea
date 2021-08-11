# frozen_string_literal: true

require 'test_helper'

class PatrolsControllerTest < ActionController::TestCase
  before do
    @patrol = patrols(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrols)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create patrol' do
    assert_difference('Patrol.count') do
      post :create,
           params: { patrol: { key: @patrol.key, name: @patrol.name, need_artc: @patrol.need_artc, need_bbm: @patrol.need_bbm,
                               need_bronze: @patrol.need_bronze, need_firstaid: @patrol.need_firstaid, need_irbc: @patrol.need_irbc, need_irbd: @patrol.need_irbd, special_event: @patrol.special_event } }
    end

    assert_redirected_to patrol_path(assigns(:patrol))
  end

  test 'should show patrol' do
    get :show, params: { id: @patrol }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @patrol }
    assert_response :success
  end

  test 'should update patrol' do
    patch :update,
          params: { id: @patrol,
                    patrol: { key: @patrol.key, name: @patrol.name, need_artc: @patrol.need_artc, need_bbm: @patrol.need_bbm,
                              need_bronze: @patrol.need_bronze, need_firstaid: @patrol.need_firstaid, need_irbc: @patrol.need_irbc, need_irbd: @patrol.need_irbd, special_event: @patrol.special_event } }
    assert_redirected_to patrol_path(assigns(:patrol))
  end

  test 'should destroy patrol' do
    assert_difference('Patrol.count', -1) do
      delete :destroy, params: { id: @patrol }
    end

    assert_redirected_to patrols_path
  end
end
