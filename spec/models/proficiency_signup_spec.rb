# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ProficiencySignup do
  before do
    @proficiency_signup = create(:proficiency_signup)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@proficiency_signup).to be_valid
    end
  end

  describe ProficiencySignup, 'association' do
    it { is_expected.to belong_to(:proficiency) }
    it { is_expected.to belong_to(:user) }
  end
end
