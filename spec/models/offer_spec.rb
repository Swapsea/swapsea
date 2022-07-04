# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Offer, type: :model do
  before(:all) do
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
end
