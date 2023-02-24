# frozen_string_literal: true

require 'rails_helper'
RSpec.describe PatrolMember do
  before do
    @patrol_member = create(:member)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@patrol_member).to be_valid
    end
  end

  describe PatrolMember, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:patrol) }
  end
end
