# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Swap do
  before do
    @swap = create(:swap)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@swap).to be_valid
    end
  end

  describe Swap, 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:roster) }
  end
end
