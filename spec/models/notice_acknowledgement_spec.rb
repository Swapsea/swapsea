# frozen_string_literal: true
require 'rails_helper'
RSpec.describe NoticeAcknowledgement, type: :model do

  before(:all) do
    @notice_acknowledgement = FactoryBot.create(:notice_acknowledgement)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@notice_acknowledgement).to be_valid
    end
  end

  describe NoticeAcknowledgement, 'association' do
     it { should belong_to(:notice)}
     it { should belong_to(:user)}
   end
end
