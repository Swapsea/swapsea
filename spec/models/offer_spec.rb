# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer, type: :model do
  before(:all) do
    @club = create(:club_with_patrols)
    @requestor = create(:member, club: @club, patrol: @club.patrols.first)
    @offerer = create(:member, club: @club, patrol: @club.patrols.second)
  end

  before do
    @request = create(:request, user: @requestor, roster: @requestor.patrol.rosters.first)
    @offer = create(:offer, user: @offerer, request: @request, roster: @offerer.patrol.rosters.first)
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
        past_roster = create(:past_roster, patrol: @offerer.patrol)
        offer_past = create(:offer, user: @offerer, request: @request, roster: past_roster)
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

  describe 'instance method' do
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

    it 'accept the only (acceptable) offer' do
      # Case: Request has no other offers. Offerer made no other offers.
      expect(@offer.accept).to be_truthy
      expect(@offer.status).to eq('accepted')
      expect(@offer.accept).to be_truthy
      # Negative tests
      expect(@offer.cancel).to be_falsey
      expect(@offer.decline).to be_falsey
      expect(@offer.unsuccessful).to be_falsey
      expect(@offer.withdraw).to be_falsey
    end

    it 'cannot accept past offer' do
      past_roster = create(:past_roster, patrol: @offerer.patrol)
      offer_past = create(:offer, user: @offerer, request: @request, roster: past_roster)
      expect(offer_past.accept).to be_falsey
    end

    it 'accept withdraws same_offer_for_other_requests' do
      # Two other requestors/requests
      requestor2 = create(:member_user, club: @club, patrol: @club.patrols.first)
      requestor3 = create(:member_user, club: @club, patrol: @club.patrols.first)

      request2 = create(:request, user: @requestor, roster: @requestor.patrol.rosters.first)
      request3 = create(:request, user: @requestor, roster: @requestor.patrol.rosters.first)

      same_offer_to_different_request_1 = create(:offer, user: @offer.user, request: request2, roster: @offer.roster)
      same_offer_to_different_request_2 = create(:offer, user: @offer.user, request: request3, roster: @offer.roster)

      expect(same_offer_to_different_request_1).to be_pending
      expect(same_offer_to_different_request_2).to be_pending

      expect(@offer.accept).to be_truthy
      expect(@offer.same_offer_for_other_requests.count).to be_zero
      # expect(same_offer_to_different_request_1.reload).to be_withdrawn
      # expect(same_offer_to_different_request_2.reload).to be_withdrawn
      expect(@offer.accept).to be_truthy
    end

    it 'accept cleans up offers for same request'
    it 'accept cancels request for same offer'
  end
end
