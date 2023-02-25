# frozen_string_literal: true

require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  before do
    @request = requests(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create request' do
    assert_difference('Request.count') do
      post :create,
           params: { request: { comment: @request.comment, email: @request.email, mobile: @request.mobile,
                                roster_id: @request.roster_id, status: @request.status, user_id: @request.user_id } }
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test 'should show request' do
    get :show, params: { id: @request }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @request }
    assert_response :success
  end

  test 'should update request' do
    patch :update,
          params: { id: @request,
                    request: { comment: @request.comment, email: @request.email, mobile: @request.mobile, roster_id: @request.roster_id,
                               status: @request.status, user_id: @request.user_id } }
    assert_redirected_to request_path(assigns(:request))
  end

  test 'should destroy request' do
    assert_difference('Request.count', -1) do
      delete :destroy, params: { id: @request }
    end

    assert_redirected_to requests_path
  end
end
