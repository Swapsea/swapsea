# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
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
        let(:user) { create(:member) }

        it { is_expected.to eq('') }
      end

      context 'when there is a default_position on the user' do
        let(:user) { create(:member, position: 'blah') }

        it { is_expected.to eq('blah') }
      end
    end

    describe 'email_exists_on_multiple_users?' do
      subject { user.email_exists_on_multiple_users? }

      let(:email) { Faker::Internet.email }
      let(:user) { create(:user, email:) }
      let(:user_two) { create(:user, email:) }

      context 'when there is only one user with the email address' do
        before { user }

        it { is_expected.to be_falsey }
      end

      context 'when there are multiple users with the email address' do
        before do
          user
          user_two
        end

        it { is_expected.to be_truthy }
      end
    end

    describe 'has_patrol?' do
      subject { member.has_patrol? }

      let(:member) { create(:member, patrol: nil) }

      context 'when the member does not have an associated patrol through patrol members' do
        it { is_expected.to be(false) }
      end

      context 'when the member has an associated patrol through patrol members' do
        let(:member) { create(:member) }

        it { is_expected.to be(true) }
      end
    end

    describe 'name' do
      subject { user.name }

      let(:user) { create(:user) }

      it { is_expected.to eq("#{user.first_name} #{user.last_name}") }
    end
  end

  describe 'relationships' do
    before do
      @club = create(:club_with_patrols)
      @patrol1 = @club.patrols.first
    end

    it 'No Patrol' do
      @unassigned = create(:member, club: @club, patrol: nil)
      expect(@unassigned.patrol_member).to be_nil
    end

    it 'No Position' do
      @unassigned = create(:member, club: @club, patrol: @patrol1)
      expect(@unassigned.patrol_member.default_position).to eq('')
    end

    it 'Bronze Member' do
      @member = create(:member, club: @club, patrol: @patrol1, position: 'Bronze Member')
      expect(@member.patrol_member.default_position).to eq('Bronze Member')
    end

    it 'Patrol Captain' do
      @member = create(:member, club: @club, patrol: @patrol1, position: 'Patrol Captain')
      expect(@member).to have_position(:patrol_captain)
    end
  end
end
