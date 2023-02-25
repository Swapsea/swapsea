# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Proficiency do
  before do
    @proficiency = create(:proficiency)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@proficiency).to be_valid
    end
  end

  describe Proficiency, 'association' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to have_many(:proficiency_signups) }
    it { is_expected.to have_many(:users).through(:proficiency_signups) }
  end
end
