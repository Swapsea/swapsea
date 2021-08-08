require 'test_helper'

class OutreachPatrolSignUpsControllerTest < ActionController::TestCase
  setup do
    @outreach_patrol_sign_up = outreach_patrol_sign_ups(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:outreach_patrol_sign_ups)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create outreach_patrol_sign_up' do
    assert_difference('OutreachPatrolSignUp.count') do
      post :create, params: { outreach_patrol_sign_up: { outreach_patrol_id: @outreach_patrol_sign_up.outreach_patrol_id, user_id: @outreach_patrol_sign_up.user_id } }
    end

    assert_redirected_to outreach_patrol_sign_up_path(assigns(:outreach_patrol_sign_up))
  end

  test 'should show outreach_patrol_sign_up' do
    get :show, params: { id: @outreach_patrol_sign_up }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @outreach_patrol_sign_up }
    assert_response :success
  end

  test 'should update outreach_patrol_sign_up' do
    patch :update, params: { id: @outreach_patrol_sign_up, outreach_patrol_sign_up: { outreach_patrol_id: @outreach_patrol_sign_up.outreach_patrol_id, user_id: @outreach_patrol_sign_up.user_id } }
    assert_redirected_to outreach_patrol_sign_up_path(assigns(:outreach_patrol_sign_up))
  end

  test 'should destroy outreach_patrol_sign_up' do
    assert_difference('OutreachPatrolSignUp.count', -1) do
      delete :destroy, params: { id: @outreach_patrol_sign_up }
    end

    assert_redirected_to outreach_patrol_sign_ups_path
  end
end
