# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Notice do
  before do
    @notice = create(:notice)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@notice).to be_valid
    end
  end

  describe Notice, 'association' do
    it { is_expected.to belong_to(:club) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:notice_acknowledgements) }
  end
end
