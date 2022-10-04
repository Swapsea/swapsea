# frozen_string_literal: true

require 'rails_helper'
require 'swapsea_sms'

RSpec.describe SwapseaSms do
  describe 'constants' do
    describe 'ACCOUNT_SID' do
      subject { described_class::ACCOUNT_SID }

      it { is_expected.to eq(ENV['TWILIO_ACCOUNT_SID']) }
    end

    describe 'AUTH_TOKEN' do
      subject { described_class::AUTH_TOKEN }

      it { is_expected.to eq(ENV['TWILIO_AUTH_TOKEN']) }
    end

    describe 'TWILIO_PHONE_NUMBER' do
      subject { described_class::TWILIO_PHONE_NUMBER }

      it { is_expected.to eq(ENV['TWILIO_PHONE_NUMBER']) }
    end
  end

  describe 'class methods' do
    describe '.roster_reminder' do
      subject { described_class.roster_reminder(user, next_roster) }

      let(:user) { create(:user) }
      let(:next_roster) { create(:roster) }

      it { is_expected.to be_a(described_class) }
    end
  end

  describe 'instance methods' do
    describe 'deliver' do
      subject { instance.deliver }

      let(:instance) { described_class.new(user, next_roster) }
      let(:user) { create(:user) }
      let(:next_roster) { create(:roster) }
      let(:recipient_number) { '+61433144308' }
      let(:twilio_endpoint) { 'https://api.twilio.com/2010-04-01/Accounts//Messages.json' }

      context 'when the recipient_number returns nil' do
        it { is_expected.to be_nil }
      end

      context 'when the recipient number returns a phone number' do
        before do
          ENV['TESTING_PHONE_NUMBER'] = recipient_number

          stub_request(:post, twilio_endpoint)
            .with(body: { Body: instance.message_body, From: nil, To: recipient_number })
            .to_return(status: 200, body: '', headers: {})
        end

        after { ENV['TESTING_PHONE_NUMBER'] = nil }

        it do
          subject
          expect(a_request(:post, twilio_endpoint)).to have_been_made.once
        end
      end
    end

    describe 'recipient_number' do
      subject { described_class.new(user, next_roster).recipient_number }

      let(:user) { create(:user) }
      let(:next_roster) { create(:roster) }

      it { is_expected.to be_nil }
    end

    describe 'message_body' do
      subject(:message_body) { described_class.new(user, roster).message_body }

      let(:user) { create(:user, club: club) }
      let(:club) { create(:club, name: long_club_name) }
      let(:long_club_name) { 'North Bondi SLSC XXXXXXXXX with an extra long name that will be truncated' }
      let(:long_patrol_name) { 'Patrol 7 XXXX with an extra long name that will be truncated' }
      let(:patrol) { create(:patrol, name: long_patrol_name) }
      let(:roster) { create(:roster, patrol: patrol) }

      it { expect(message_body.size).to be <= 160 }
    end
  end
end
