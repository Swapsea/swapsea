# frozen_string_literal: true

require 'rails_helper'
RSpec.describe StagingUser, type: :model do
  before do
    @staging_user = create(:staging_user)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@staging_user).to be_valid
    end
  end
end
