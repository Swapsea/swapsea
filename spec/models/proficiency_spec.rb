# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Proficiency, type: :model do

  before(:all) do
    @proficiency = FactoryBot.create(:proficiency)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@proficiency).to be_valid
    end
  end

  describe Proficiency, 'association' do
     it { should belong_to(:club).with_foreign_key('organisation').with_primary_key('name') }
     it { should have_many(:proficiency_signups) }
     it { should have_many(:users).through(:proficiency_signups) }
   end
end
