# frozen_string_literal: true
require 'rails_helper'
require 'capybara'
describe 'home', :type => :feature do

  before(:all) do
    @user = FactoryBot.create(:user)
  end

	it 'Home page' do
	    visit '/'
	    expect(page).to have_text('Welcome to Swapsea')
	end

  it 'signs users in' do
    visit '/users/sign_in'
    fill_in 'user[email]', :with => @user.email
    fill_in 'user[password]', :with => 'swapsea'
    click_button 'Login'
    expect(page).to have_text('Notice Board')
  end

  it 'user should receive an email and successfully reset password' do
    visit '/users/password/new'
    fill_in 'user[email]',  with:  @user.email
    click_button 'Send Password Reset'
  end

end
