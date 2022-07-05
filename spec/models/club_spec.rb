# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Club, type: :model do
  before do
    @club = create(:club)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@club).to be_valid
    end
  end

  describe Club, 'association' do
    it { is_expected.to have_many(:patrols) }
    it { is_expected.to have_many(:patrol_members).through(:patrols) }
    it { is_expected.to have_many(:rosters).through(:patrols) }
    it { is_expected.to have_many(:requests).through(:rosters) }
    it { is_expected.to have_many(:users).through(:patrol_members) }
    it { is_expected.to have_many(:awards).through(:users) }
  end
end
