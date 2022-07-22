# frozen_string_literal: true

require 'rails_helper'
RSpec.describe EventLog, type: :model do
  before do
    @event_log = create(:event_log)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@event_log).to be_valid
    end
  end
end
