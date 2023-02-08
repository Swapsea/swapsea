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
    
    describe 'offered_roster_valid?' do
      it 'true for future roster' do
        expect(@offer).to be_offered_roster_valid
      end
      it 'true for no roster (sub only)' do
        @offer.roster = nil
        expect(@offer).to be_offered_roster_valid
      end
      it 'false for past roster' do
        @offer.roster = create(:past_roster, patrol: @offerer.patrol)
        expect(@offer).not_to be_offered_roster_valid
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
      requestor2 = create(:member, club: @club, patrol: @club.patrols.first)
      requestor3 = create(:member, club: @club, patrol: @club.patrols.first)

      request2 = create(:request, user: requestor2, roster: requestor2.patrol.rosters.first)
      request3 = create(:request, user: requestor3, roster: requestor3.patrol.rosters.first)

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

    it 'accept cleans up other_offers_for_the_same_request' do
      offerer2 = create(:member, club: @club, patrol: @club.patrols.second)
      offerer3 = create(:member, club: @club, patrol: @club.patrols.third)

      other_offers_for_the_same_request2 = create(:offer, user: offerer2, request: @request, roster: offerer2.patrol.rosters.first)
      other_offers_for_the_same_request22 = create(:offer, user: offerer2, request: @request, roster: offerer2.patrol.rosters.second)

      other_offers_for_the_same_request3 = create(:offer, user: offerer3, request: @request, roster: offerer3.patrol.rosters.first)
      other_offers_for_the_same_request33 = create(:offer, user: offerer3, request: @request, roster: offerer3.patrol.rosters.second)

      expect(other_offers_for_the_same_request2).to be_pending
      expect(other_offers_for_the_same_request22).to be_pending
      expect(other_offers_for_the_same_request3).to be_pending
      expect(other_offers_for_the_same_request33).to be_pending

      expect(@offer.accept).to be_truthy
      expect(@offer.other_offers_for_the_same_request.count).to be_zero
      # expect(other_offers_for_the_same_request2.reload).to be_unsuccessful
      # expect(other_offers_for_the_same_request22.reload).to be_unsuccessful
      # expect(other_offers_for_the_same_request3.reload).to be_unsuccessful
      # expect(other_offers_for_the_same_request33.reload).to be_unsuccessful
      expect(@offer.accept).to be_truthy
    end

    it 'accept closes corresponding_requests' do
      # Request matching accepted offer
      offer_corresponding_request = create(:request, user: @offerer, roster: @offer.roster)

      expect(@offer.accept).to be_truthy
      expect(@offer.corresponding_requests.count).to be_zero
      # expect(offer_corresponding_request.reload).to be_cancelled
      expect(@offer.accept).to be_truthy
    end

    it 'accept withdraws offers_that_match_request' do
      requestor2 = create(:member, club: @club, patrol: @club.patrols.second)
      requestor3 = create(:member, club: @club, patrol: @club.patrols.third)

      request2 = create(:request, user: requestor2, roster: requestor2.patrol.rosters.first)
      request3 = create(:request, user: requestor3, roster: requestor3.patrol.rosters.first)

      # requestor's offers for their request
      requestor_corresponding_offer2 = create(:offer, user: @requestor, request: request2, roster: @offer.roster)
      requestor_corresponding_offer3 = create(:offer, user: @requestor, request: request3, roster: @offer.roster)

      expect(@offer.accept).to be_truthy
      expect(@offer.request.offers_that_match_request.count).to be_zero
      # expect(same_offer_to_different_request_2.reload).to be_withdrawn
      expect(@offer.accept).to be_truthy
    end
  end
end
