# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Offer, type: :model do
  before do
    @offer = create(:offer)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@offer).to be_valid
    end

    it 'has default status pending' do
      expect(@offer).to have_attributes(status: 'pending')
    end
  end

  describe Offer, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:request) }
    it { is_expected.to belong_to(:roster) }
  end

  describe 'status' do
    describe 'accepted?' do
      it 'true for accepted' do
        # @offer.accept
        @offer.status = 'accepted'
        expect(@offer).to be_accepted
      end
    end

    describe 'cancelled?' do
      it 'true for cancelled' do
        @offer.cancel
        expect(@offer).to be_cancelled
      end
    end

    describe 'declined?' do
      it 'true for declined' do
        @offer.decline
        expect(@offer).to be_declined
      end
    end

    describe 'pending?' do
      it 'true for pending in future' do
        expect(@offer).to be_pending
      end

      it 'false for pending in past' do
        offer_past = create(:offer, :past_dated_roster)
        expect(offer_past).not_to be_pending
      end

      it 'false for not pending in future' do
        @offer.withdraw
        expect(@offer).not_to be_pending
      end
    end

    describe 'unsuccessful?' do
      it 'true for unsuccessful' do
        @offer.unsuccessful
        expect(@offer).to be_unsuccessful
      end
    end

    describe 'withdrawn?' do
      it 'true for withdrawn' do
        @offer.withdraw
        expect(@offer).to be_withdrawn
      end
    end
  end

  describe 'instance methods' do
    it 'decline without remark' do
      @offer.decline(nil)
      expect(@offer.status).to eq('declined')
      expect(@offer.decline_remark).to be_nil
      expect(@offer.decline(nil)).to be_truthy
      # Negative tests
      expect(@offer.accept).to be_falsey
      expect(@offer.cancel).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'decline with remark' do
      remark = 'sorry mate'
      @offer.decline(remark)
      expect(@offer.status).to eq('declined')
      expect(@offer.decline_remark).to eq(remark)
      # Negative tests
      expect(@offer.accept).to be_falsey
      expect(@offer.cancel).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'withdraw' do
      expect(@offer.withdraw).to be_truthy
      expect(@offer.status).to eq('withdrawn')
      expect(@offer.withdraw).to be_truthy
      # Negative tests
      expect(@offer.accept).to be_falsey
      expect(@offer.cancel).to be_falsey
      expect(@offer.decline).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
    end

    it 'unsuccessful' do
      expect(@offer.unsuccessful).to be_truthy
      expect(@offer.status).to eq('unsuccessful')
      expect(@offer.unsuccessful).to be_truthy
      # Negative tests
      expect(@offer.accept).to be_falsey
      expect(@offer.cancel).to be_falsey
      expect(@offer.decline).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'cancel' do
      expect(@offer.cancel).to be_truthy
      expect(@offer.status).to eq('cancelled')
      expect(@offer.cancel).to be_truthy
      # Negative tests
      expect(@offer.accept).to be_falsey
      expect(@offer.decline).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'accept (1)' do
      # Case: Request has no other offers. Offerer made no requests.
      expect(@offer.accept).to be_truthy
      expect(@offer.status).to eq('accepted')
      expect(@offer.accept).to be_truthy
      # Negative tests
      expect(@offer.cancel).to be_falsey
      expect(@offer.decline).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'accept past offer' do
      offer_past = create(:offer, :past_dated_roster)
      expect(offer_past.accept).to be_falsey
    end
  end
end
