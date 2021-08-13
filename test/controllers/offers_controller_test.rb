# frozen_string_literal: true

require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  before do
    @offer = offers(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create offer' do
    assert_difference('Offer.count') do
      post :create,
           params: { offer: { comment: @offer.comment, email: @offer.email, mobile: @offer.mobile, request_id: @offer.request_id,
                              status: @offer.status, user_id: @offer.user_id } }
    end

    assert_redirected_to offer_path(assigns(:offer))
  end

  test 'should show offer' do
    get :show, params: { id: @offer }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @offer }
    assert_response :success
  end

  test 'should update offer' do
    patch :update,
          params: { id: @offer,
                    offer: { comment: @offer.comment, email: @offer.email, mobile: @offer.mobile, request_id: @offer.request_id,
                             status: @offer.status, user_id: @offer.user_id } }
    assert_redirected_to offer_path(assigns(:offer))
  end

  test 'should destroy offer' do
    assert_difference('Offer.count', -1) do
      delete :destroy, params: { id: @offer }
    end

    assert_redirected_to offers_path
  end
end
