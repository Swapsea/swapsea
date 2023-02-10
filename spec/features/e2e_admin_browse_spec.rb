# frozen_string_literal: true

require 'rails_helper'
require 'capybara'
require 'capybara-screenshot/rspec'

describe 'e2e Happy Path - Admin' do
  before do
    @club = create(:club_with_patrols)
    @user = create(:admin, club: @club, patrol: @club.patrols.first)
    Capybara.page.current_window.resize_to(1200, 800)
  end

  it 'visit home page' do
    visit '/'
    expect(page).to have_text('Welcome to Swapsea')
  end

  it 'signs admin in and clicks around', js: true do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'swapsea'
    click_button 'Login'
    expect(page).to have_text('NOTICE BOARD')

    visit '/admin'

    visit '/clubs/admin'
    wait_for_ajax
    expect(page).to have_text('CLUBS')

    visit '/users/admin'
    wait_for_ajax
    expect(page).to have_text('MEMBERS')

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
