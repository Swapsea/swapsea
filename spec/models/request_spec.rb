# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Request do
  before do
    @request = create(:request)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@request).to be_valid
    end

    it 'has default status open' do
      expect(@request).to have_attributes(status: 'open')
    end
  end

  describe Request, 'association' do
    it { is_expected.to belong_to(:roster) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:offers) }
  end

  describe 'status' do
    it 'true for open' do
      @request.status = 'open'
      expect(@request).to be_open
    end

    it 'true for cancelled' do
      @request.status = 'cancelled'
      expect(@request).to be_cancelled
    end
  end

  describe 'instance methods' do
    it 'cancel' do
      expect(@request.cancel).to be_truthy
      expect(@request.status).to eq('cancelled')
      expect(@request.cancel).to be_truthy
      # Negative tests
      expect(@request).not_to be_open
    end

    it 'succeeded' do
      expect(@request.succeeded).to be_truthy
      expect(@request.status).to eq('successful')
      # Can't mark successful again
      expect(@request.succeeded).to be_falsey
      # Negative tests
      expect(@request).not_to be_open
    end

    it 'detects existing offer' do
      @user = create(:user)
      @roster = create(:roster)

      expect(@request).not_to be_offer_already_exists(@roster, @user)
      # create offer
      @offer = create(:offer, user: @user, request: @request, roster: @roster)
      expect(@request).to be_offer_already_exists(@roster, @user)
    end
  end
end
