# frozen_string_literal: true

module CapybaraHelpers
  def authenticate_user(user)
    visit '/users/sign_in'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'swapsea'

    click_button 'Login'
  end
  
  def logout
    # TODO: WebDriver can't find "a.md-trigger"
    # find('a.md-trigger').click
    # click_link "logout-link"
    find(link: "a.logout-link").click

    # Logout cancelled
    click_on 'logout-cancel'
    # # find(link: "a.logout-cancel").click

    # # Logout confirmed
    # find('a.dropdown-toggle').click
    find('a.md-trigger').click
    # # click_link 'logout-link'
    # # find("a.logout-link").click

    click_link 'logout-confirm'
    # # find("a.logout-confirm").click
    # find('a.btn-success').click

    # expect(page).to have_text('Welcome to Swapsea')
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, type: :feature
end
