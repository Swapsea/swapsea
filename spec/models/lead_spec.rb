# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Lead do
  before do
    @lead = create(:lead)
  end

  describe '#Atributes' do
    it 'is valid with valid attributes' do
      expect(@lead).to be_valid
    end
  end

  it do
    expect(subject).to validate_presence_of(:name)
      .with_message('Cannot be blank.')
  end

  it do
    expect(subject).to validate_presence_of(:organisation)
      .with_message('Cannot be blank.')
  end

  it do
    expect(subject).to validate_uniqueness_of(:email)
      .with_message('This email has already been submitted.')
  end
end
