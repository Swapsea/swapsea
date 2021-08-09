# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OutreachPatrol, type: :model do
  before(:all) do
    @outreach_patrol = FactoryBot.create(:outreach_patrol)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@outreach_patrol).to be_valid
    end
  end

  describe OutreachPatrol, 'association' do
    it { should belong_to(:club).with_foreign_key('organisation').with_primary_key('name') }
    it { should have_many(:outreach_patrol_sign_ups) }
    it { should have_many(:users).through(:outreach_patrol_sign_ups) }
  end
end
