# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Swap, type: :model do
  before(:all) do
    @swap = FactoryBot.create(:swap)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@swap).to be_valid
    end
  end

  describe Swap, 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:roster) }
  end
end
