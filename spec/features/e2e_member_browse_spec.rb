# frozen_string_literal: true

require 'rails_helper'
require 'capybara'

describe 'e2e Happy Path - User' do
  before do
    @user = create(:member)
    Capybara.page.current_window.resize_to(1024, 768)
  end

  it 'visit public pages' do
    visit '/'
    expect(page).to have_text('Welcome to Swapsea')

    visit '/faq'
    expect(page).to have_text('Frequently Asked Questions')

    visit '/setup'
    expect(page).to have_text('Setup Guide')

    visit '/contact-us'
    expect(page).to have_text('Contact Us')

    visit '/terms-of-use'
    expect(page).to have_text('Terms of Use')
  end

  it 'signs users in and clicks around', js: true do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'swapsea'
    click_button 'Login'
    expect(page).to have_text('NOTICE BOARD')

    visit '/dashboard'
    expect(page).to have_text('help@swapsea.com.au')
    expect(page).to have_text('Swapsea')

    visit '/swaps'
    expect(page).to have_text('SWAP REQUESTS')

    visit '/swaps/confirmed'
    expect(page).to have_text('CONFIRMED SWAPS')

    visit '/swaps/my-requests'
    expect(page).to have_text('MY REQUESTS')

    visit '/swaps/my-offers'
    expect(page).to have_text('MY OFFERS')

    visit '/patrols'
    expect(page).to have_text('Patrols')

    visit '/rosters'
    expect(page).to have_text('Rosters')

    visit '/proficiencies'
    expect(page).to have_text('Skills Maintenance')

    visit '/outreach_patrols'
    expect(page).to have_text('Extra Patrols')

    # page.save_and_open_screenshot

    # Logout cancelled
    find('a.dropdown-toggle').click

    # TODO: COMMENTED OUT SINCE WebDriver can't find "a.md-trigger"
    # find('a.md-trigger').click
    # # click_link "logout-link"
    # # find(link: "a.logout-link").click

    # click_on 'logout-cancel'
    # # find(link: "a.logout-cancel").click

    # # Logout confirmed
    # find('a.dropdown-toggle').click
    # find('a.md-trigger').click
    # # click_link 'logout-link'
    # # find("a.logout-link").click

    # # click_link 'logout-confirm'
    # # find("a.logout-confirm").click
    # find('a.btn-success').click

    # expect(page).to have_text('Welcome to Swapsea')
  end
end
