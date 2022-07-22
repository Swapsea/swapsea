# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Email, type: :model do
  before do
    @email = create(:email)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@email).to be_valid
    end
  end
end
