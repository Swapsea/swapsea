# frozen_string_literal: true

require 'rails_helper'
RSpec.describe NoticeAcknowledgement do
  before do
    @notice_acknowledgement = create(:notice_acknowledgement)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@notice_acknowledgement).to be_valid
    end
  end

  describe NoticeAcknowledgement, 'association' do
    it { is_expected.to belong_to(:notice) }
    it { is_expected.to belong_to(:user) }
  end
end
