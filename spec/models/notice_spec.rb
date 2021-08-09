# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Notice, type: :model do

  before(:all) do
    @notice = FactoryBot.create(:notice)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@notice).to be_valid
    end
  end

  describe Notice, 'association' do
     it { should belong_to(:club).with_foreign_key('organisation').with_primary_key('name') }
     it { should belong_to(:user)}
     it { should have_many(:notice_acknowledgements)}
   end
end
