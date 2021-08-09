# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Roster, type: :model do

	before(:all) do
    @roster = FactoryBot.create(:roster)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@roster).to be_valid
    end
  end

  describe Roster, 'association' do
    it { should belong_to(:patrol).with_foreign_key('patrol_name').with_primary_key('name') }
    it { should have_many(:swaps) }
    it { should have_many(:requests) }
    it { should have_many(:offers) }
	end
end
