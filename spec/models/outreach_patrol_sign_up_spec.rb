# frozen_string_literal: true
require 'rails_helper'
RSpec.describe OutreachPatrolSignUp, type: :model do

  before(:all) do
    @outreach_patrol_sign_up = FactoryBot.create(:outreach_patrol_sign_up)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@outreach_patrol_sign_up).to be_valid
    end
  end

  describe OutreachPatrolSignUp, 'association' do
     it { should belong_to(:user)}
     it { should belong_to(:outreach_patrol) }
   end
end
