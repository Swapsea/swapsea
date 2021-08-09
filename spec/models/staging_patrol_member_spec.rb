# frozen_string_literal: true
require 'rails_helper'
RSpec.describe StagingPatrolMember, :type => :model do

	before(:all) do
    @staging_patrol_member = FactoryBot.create(:staging_patrol_member)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@staging_patrol_member).to be_valid
    end
  end

end
