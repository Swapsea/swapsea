# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Patrol do
  before do
    @patrol = create(:patrol)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@patrol).to be_valid
    end
  end

  describe Patrol, 'association' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to have_many(:patrol_members) }
    it { is_expected.to have_many(:users).through(:patrol_members) }
    it { is_expected.to have_many(:rosters) }
    it { is_expected.to have_many(:awards).through(:users) }
  end
end
