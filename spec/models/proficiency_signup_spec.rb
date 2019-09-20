require "rails_helper"
RSpec.describe ProficiencySignup, :type => :model do

	before(:all) do
    @proficiency_signup = FactoryBot.create(:proficiency_signup)
  end

  context '#Atributes' do
    it "is valid with valid attributes" do
      expect(@proficiency_signup).to be_valid
    end
  end

  describe ProficiencySignup, 'association' do
    it { should belong_to(:proficiency)}
    it { should belong_to(:user)}
	end
end