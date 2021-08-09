# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Lead, type: :model do

  before(:all) do
    @lead = FactoryBot.create(:lead)
  end

  context '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@lead).to be_valid
    end
  end

  it do
    should validate_presence_of(:name).
      with_message('Cannot be blank.')
  end

  it do
    should validate_presence_of(:organisation).
      with_message('Cannot be blank.')
  end

  it do
    should validate_presence_of(:organisation).
      with_message('Cannot be blank.')
  end

  it do
    should validate_uniqueness_of(:email).
      with_message('This email has already been submitted.')
  end
end
