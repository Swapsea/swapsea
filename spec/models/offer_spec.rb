require 'rails_helper'
RSpec.describe Offer, :type => :model do

	before(:all) do
    @offer = FactoryBot.create(:offer)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@offer).to be_valid
    end
  end

  describe Offer, 'association' do
    it { should belong_to(:user)}
    it { should belong_to(:request) }
    it { should belong_to(:roster) }
	end
end
