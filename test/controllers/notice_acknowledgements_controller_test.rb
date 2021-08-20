# frozen_string_literal: true

require 'test_helper'

class NoticeAcknowledgementsControllerTest < ActionController::TestCase
  before do
    @notice_acknowledgement = notice_acknowledgements(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:notice_acknowledgements)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create notice_acknowledgement' do
    assert_difference('NoticeAcknowledgement.count') do
      post :create,
           params: { notice_acknowledgement: { notice_id: @notice_acknowledgement.notice_id,
                                               user_id: @notice_acknowledgement.user_id } }
    end

    assert_redirected_to notice_acknowledgement_path(assigns(:notice_acknowledgement))
  end

  test 'should show notice_acknowledgement' do
    get :show, params: { id: @notice_acknowledgement }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @notice_acknowledgement }
    assert_response :success
  end

  test 'should update notice_acknowledgement' do
    patch :update,
          params: { id: @notice_acknowledgement,
                    notice_acknowledgement: { notice_id: @notice_acknowledgement.notice_id,
                                              user_id: @notice_acknowledgement.user_id } }
    assert_redirected_to notice_acknowledgement_path(assigns(:notice_acknowledgement))
  end

  test 'should destroy notice_acknowledgement' do
    assert_difference('NoticeAcknowledgement.count', -1) do
      delete :destroy, params: { id: @notice_acknowledgement }
    end

    assert_redirected_to notice_acknowledgements_path
  end
end
