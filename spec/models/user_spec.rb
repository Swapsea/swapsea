# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end
  end

  describe User, 'association' do
    it { is_expected.to have_many(:awards) }
    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:offers) }
    it { is_expected.to have_one(:patrol_member) }
    it { is_expected.to have_one(:patrol).through(:patrol_member) }
    it { is_expected.to have_many(:rosters).through(:patrol) }
    it { is_expected.to have_many(:proficiency_signups) }
    it { is_expected.to have_many(:proficiencies).through(:proficiency_signups) }
    it { is_expected.to have_many(:swaps) }
    it { is_expected.to have_many(:notices) }
    it { is_expected.to have_many(:notice_acknowledgements) }
  end

  context '::name' do
    let(:user) { create :user, first_name: 'First', last_name: 'Last' }

    it 'returns the correct name string' do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe User do
    let(:club) { double(name: 'organisation') }

    it 'find club by name' do
      expect(Club).to receive(:find_by_name).and_return(club)
      expect(Club.find_by(name: 'organisation')).to eq club
      # expect(Club.find_by_name('organisation')).to eq club
    end
  end
end
