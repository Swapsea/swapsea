# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Role, type: :model do
  before(:all) do
    @role = create(:role)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@role).to be_valid
    end
  end

  describe Role, 'association' do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to belong_to(:resource) }
  end
end
