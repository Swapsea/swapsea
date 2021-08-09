# frozen_string_literal: true
require 'rails_helper'
RSpec.describe EventLog, type: :model do

	before(:all) do
    @event_log = FactoryBot.create(:event_log)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@event_log).to be_valid
    end
  end

end
