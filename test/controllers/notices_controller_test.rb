# frozen_string_literal: true
require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  setup do
    @notice = notices(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:notices)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create notice' do
    assert_difference('Notice.count') do
      post :create, params: { notice: { club_id: @notice.club_id, desc: @notice.desc, image: @notice.image, link: @notice.link, link_desc: @notice.link_desc, system_wide: @notice.system_wide, title: @notice.title, user_id: @notice.user_id, video: @notice.video, visible: @notice.visible, visible_from: @notice.visible_from, visible_to: @notice.visible_to } }
    end

    assert_redirected_to notice_path(assigns(:notice))
  end

  test 'should show notice' do
    get :show, params: { id: @notice }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @notice }
    assert_response :success
  end

  test 'should update notice' do
    patch :update, params: { id: @notice, notice: { club_id: @notice.club_id, desc: @notice.desc, image: @notice.image, link: @notice.link, link_desc: @notice.link_desc, system_wide: @notice.system_wide, title: @notice.title, user_id: @notice.user_id, video: @notice.video, visible: @notice.visible, visible_from: @notice.visible_from, visible_to: @notice.visible_to } }
    assert_redirected_to notice_path(assigns(:notice))
  end

  test 'should destroy notice' do
    assert_difference('Notice.count', -1) do
      delete :destroy, params: { id: @notice }
    end

    assert_redirected_to notices_path
  end
end
