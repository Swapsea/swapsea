require "rails_helper"
RSpec.describe Setting, :type => :model do

	before(:all) do
    @setting = FactoryBot.create(:setting)
  end

  context '#Atributes' do
    it "is valid with valid attributes" do
      expect(@setting).to be_valid
    end
  end
end
