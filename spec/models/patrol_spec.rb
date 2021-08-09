# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Patrol, :type => :model do

	before(:all) do
    @patrol = FactoryBot.create(:patrol)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@patrol).to be_valid
    end
  end

  describe Patrol, 'association' do
    it { should belong_to(:club).with_foreign_key('organisation').with_primary_key('name') }
    it { should have_many(:patrol_members).with_foreign_key('patrol_name').with_primary_key('name') }
    it { should have_many(:users).through(:patrol_members) }
    it { should have_many(:rosters).with_foreign_key('patrol_name').with_primary_key('name') }
    it { should have_many(:awards).through(:users) }
	end
end
