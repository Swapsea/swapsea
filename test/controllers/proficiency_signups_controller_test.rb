require 'test_helper'

class ProficiencySignupsControllerTest < ActionController::TestCase
  setup do
    @proficiency_signup = proficiency_signups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proficiency_signups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proficiency_signup" do
    assert_difference('ProficiencySignup.count') do
      post :create, proficiency_signup: { proficiency_id: @proficiency_signup.proficiency_id, user_id: @proficiency_signup.user_id }
    end

    assert_redirected_to proficiency_signup_path(assigns(:proficiency_signup))
  end

  test "should show proficiency_signup" do
    get :show, id: @proficiency_signup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proficiency_signup
    assert_response :success
  end

  test "should update proficiency_signup" do
    patch :update, id: @proficiency_signup, proficiency_signup: { proficiency_id: @proficiency_signup.proficiency_id, user_id: @proficiency_signup.user_id }
    assert_redirected_to proficiency_signup_path(assigns(:proficiency_signup))
  end

  test "should destroy proficiency_signup" do
    assert_difference('ProficiencySignup.count', -1) do
      delete :destroy, id: @proficiency_signup
    end

    assert_redirected_to proficiency_signups_path
  end
end
