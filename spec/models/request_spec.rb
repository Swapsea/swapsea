# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Request, type: :model do

	before(:all) do
    @request = FactoryBot.create(:request)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@request).to be_valid
    end
  end

  describe Request, 'association' do
    it { should belong_to(:roster) }
    it { should belong_to(:user) }
    it { should have_many(:offers) }
	end
end
