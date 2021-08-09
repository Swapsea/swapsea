# frozen_string_literal: true
require 'rails_helper'
require 'capybara'
describe 'home', type: :feature do

  before(:all) do
    @user = FactoryBot.create(:user)
  end

  it 'Dashboard' do
    visit '/dashboard'
    expect(page).to have_text('help@swapsea.com.au')
    expect(page).to have_text('Swapsea')
  end
end
