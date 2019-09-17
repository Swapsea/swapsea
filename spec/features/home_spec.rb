require 'rails_helper'
require 'capybara'
describe "home", :type => :feature do

  before(:all) do
    @user = FactoryBot.create(:user)
  end

  before(:all) do
    @club = FactoryBot.create(:club)
  end

	it "Home page" do
	    visit '/'
	    expect(page).to have_text('Welcome to Swapsea')
	    
	end

  it "signs users in" do
    visit "/users/sign_in"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "swapsea"
    click_button "Login"
    page.should have_content('Login Successful')
  end
end