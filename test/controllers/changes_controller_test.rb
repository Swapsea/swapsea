# frozen_string_literal: true

require 'test_helper'

class ChangesControllerTest < ActionController::TestCase
  before do
    @change = changes(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:changes)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create change' do
    assert_difference('Change.count') do
      post :create,
           params: { change: { on_off_patrol: @change.on_off_patrol, roster_id: @change.roster_id,
                               user_id: @change.user_id } }
    end

    assert_redirected_to change_path(assigns(:change))
  end

  test 'should show change' do
    get :show, params: { id: @change }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @change }
    assert_response :success
  end

  test 'should update change' do
    patch :update,
          params: { id: @change,
                    change: { on_off_patrol: @change.on_off_patrol, roster_id: @change.roster_id,
                              user_id: @change.user_id } }
    assert_redirected_to change_path(assigns(:change))
  end

  test 'should destroy change' do
    assert_difference('Change.count', -1) do
      delete :destroy, params: { id: @change }
    end

    assert_redirected_to changes_path
  end
end
