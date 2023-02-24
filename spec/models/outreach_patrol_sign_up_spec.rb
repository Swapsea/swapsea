# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OutreachPatrolSignUp do
  before do
    @outreach_patrol_sign_up = create(:outreach_patrol_sign_up)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@outreach_patrol_sign_up).to be_valid
    end
  end

  describe OutreachPatrolSignUp, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:outreach_patrol) }
  end
end
