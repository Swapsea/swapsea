# frozen_string_literal: true

require 'rails_helper'
RSpec.describe StagingAward, type: :model do
  before do
    @staging_award = create(:staging_award)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@staging_award).to be_valid
    end
  end
end
