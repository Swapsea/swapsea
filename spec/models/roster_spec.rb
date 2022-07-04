# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Roster, type: :model do
  before(:all) do
    @roster = create(:roster)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@roster).to be_valid
    end
  end

  describe Roster, 'association' do
    it { is_expected.to belong_to(:patrol).with_foreign_key('patrol_name').with_primary_key('name') }
    it { is_expected.to have_many(:swaps) }
    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:offers) }
  end
end
