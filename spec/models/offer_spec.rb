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
  end

  describe Offer, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:request) }
    it { is_expected.to belong_to(:roster) }
  end

  describe 'instance methods' do
    describe 'decline' do

      it 'without remark' do
        @offer.decline(nil)
        expect(@offer.status).to eq('declined')
        expect(@offer.decline_remark).to eq(nil)
      end

      it 'with remark' do
        remark = 'sorry mate'
        @offer.decline(remark)
        expect(@offer.status).to eq('declined')
        expect(@offer.decline_remark).to eq(remark)
      end
    end
  end
end
