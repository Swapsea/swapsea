# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Roster do
  before do
    @roster = create(:roster)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@roster).to be_valid
    end
  end

  describe Roster, 'association' do
    it { is_expected.to belong_to(:patrol) }
    it { is_expected.to have_many(:swaps) }
    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:offers) }
  end
end
