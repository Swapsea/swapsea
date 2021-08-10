# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Request, type: :model do
  before(:all) do
    @request = FactoryBot.create(:request)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@request).to be_valid
    end
  end

  describe Request, 'association' do
    it { is_expected.to belong_to(:roster) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:offers) }
  end
end
