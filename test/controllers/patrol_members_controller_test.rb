require 'test_helper'

class PatrolMembersControllerTest < ActionController::TestCase
  setup do
    @patrol_member = patrol_members(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrol_members)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create patrol_member' do
    assert_difference('PatrolMember.count') do
      post :create, params: { patrol_member: { default_position: @patrol_member.default_position, patrol_id: @patrol_member.patrol_id, patrol_key: @patrol_member.patrol_key, user_id: @patrol_member.user_id } }
    end

    assert_redirected_to patrol_member_path(assigns(:patrol_member))
  end

  test 'should show patrol_member' do
    get :show, params: { id: @patrol_member }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @patrol_member }
    assert_response :success
  end

  test 'should update patrol_member' do
    patch :update, params: { id: @patrol_member, patrol_member: { default_position: @patrol_member.default_position, patrol_id: @patrol_member.patrol_id, patrol_key: @patrol_member.patrol_key, user_id: @patrol_member.user_id } }
    assert_redirected_to patrol_member_path(assigns(:patrol_member))
  end

  test 'should destroy patrol_member' do
    assert_difference('PatrolMember.count', -1) do
      delete :destroy, params: { id: @patrol_member }
    end

    assert_redirected_to patrol_members_path
  end
end
