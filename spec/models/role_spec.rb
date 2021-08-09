# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Role, type: :model do

  before(:all) do
    @role = FactoryBot.create(:role)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@role).to be_valid
    end
  end

  describe Role, 'association' do
     it {should have_and_belong_to_many(:users) }
     it {should belong_to(:resource) }
   end
end
