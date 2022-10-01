# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(create(:user)).to be_valid
    end
  end

  describe 'associations' do
    # Belongs to.
    it { is_expected.to belong_to(:club) }

    # Has one and has many.
    it { is_expected.to have_many(:awards) }
    it { is_expected.to have_many(:requests) }
    it { is_expected.to have_many(:offers) }
    it { is_expected.to have_one(:patrol_member) }
    it { is_expected.to have_one(:patrol).through(:patrol_member) }
    it { is_expected.to have_many(:rosters).through(:patrol) }
    it { is_expected.to have_many(:proficiency_signups) }
    it { is_expected.to have_many(:proficiencies).through(:proficiency_signups) }
    it { is_expected.to have_many(:outreach_patrol_sign_ups) }
    it { is_expected.to have_many(:outreach_patrol).through(:outreach_patrol_sign_ups) }
    it { is_expected.to have_many(:swaps) }
    it { is_expected.to have_many(:notices) }
    it { is_expected.to have_many(:notice_acknowledgements) }
  end

  describe 'scopes' do
    describe 'with_club' do
      subject { described_class.with_club(club) }

      let(:club) { create(:club) }

      before { club }

      it { is_expected.to be_empty }
    end
  end

  describe 'instance methods' do
    describe 'default_position' do
      subject { user.default_position }

      context 'when there is no default_position on the user' do
        let(:user) { create(:user, default_position: nil) }

        it { is_expected.to eq('Member') }
      end

      context 'when there is a default_position on the user' do
        let(:user) { create(:user, default_position: 'blah') }

        it { is_expected.to eq('blah') }
      end
    end

    describe 'has_patrol?' do
      subject { user.has_patrol? }

      let(:user) { create(:user) }

      context 'when the user does not have an associated patrol through patrol members' do
        it { is_expected.to be(false) }
      end

      context 'when the user has an associated patrol through patrol members' do
        let(:patrol) { create(:patrol) }

        before do
          create(:patrol_member, user: user, patrol: patrol)
        end

        it { is_expected.to be(true) }
      end
    end

    describe 'name' do
      subject { user.name }

      let(:user) { create(:user) }

      it { is_expected.to eq("#{user.first_name} #{user.last_name}") }
    end

    describe 'organisation' do
      subject { user.organisation }

      let(:user) { create(:user) }

      it { is_expected.to eq(user.club.name) }
    end
  end
end
