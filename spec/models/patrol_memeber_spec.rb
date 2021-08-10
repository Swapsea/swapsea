# frozen_string_literal: true

require 'rails_helper'
RSpec.describe PatrolMember, type: :model do
  before(:all) do
    @patrol_member = FactoryBot.create(:patrol_member)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@patrol_member).to be_valid
    end
  end

  describe PatrolMember, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:patrol).with_foreign_key('patrol_name').with_primary_key('name') }
  end
end
