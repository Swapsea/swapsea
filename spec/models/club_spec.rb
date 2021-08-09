# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Club, type: :model do
  before(:all) do
    @club = FactoryBot.create(:club)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@club).to be_valid
    end
  end

  describe Club, 'association' do
    it { should have_many(:patrols) }
    it { should have_many(:patrol_members).through(:patrols) }
    it { should have_many(:rosters).through(:patrols) }
    it { should have_many(:rosters).through(:patrols) }
    it { should have_many(:requests).through(:rosters) }
    it { should have_many(:users).through(:patrol_members) }
    it { should have_many(:awards).through(:users) }
  end
end
