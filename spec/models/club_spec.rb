require "rails_helper"
RSpec.describe Club, :type => :model do

	before(:all) do
    @club = FactoryBot.create(:club)
  end

  context '#Atributes' do
    it "is valid with valid attributes" do
      expect(@club).to be_valid
    end
  end

end
