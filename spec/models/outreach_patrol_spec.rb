# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OutreachPatrol, type: :model do
  before(:all) do
    @outreach_patrol = create(:outreach_patrol)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@outreach_patrol).to be_valid
    end
  end

  describe OutreachPatrol, 'association' do
    it { is_expected.to belong_to(:club).with_foreign_key('organisation').with_primary_key('name') }
    it { is_expected.to have_many(:outreach_patrol_sign_ups) }
    it { is_expected.to have_many(:users).through(:outreach_patrol_sign_ups) }
  end
end
