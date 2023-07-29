# frozen_string_literal: true

require 'rails_helper'
require 'capybara'
require 'capybara-screenshot/rspec'

describe 'e2e Happy Path - Anonymous User' do
  it 'visit public pages' do
    visit '/'
    expect(page).to have_text('Patrol Swaps Made Easy')

    visit '/faq'
    expect(page).to have_text('Frequently Asked Questions')

    visit '/setup'
    expect(page).to have_text('Setup Guide')

    visit '/contact-us'
    expect(page).to have_text('Contact Us')

    visit '/terms-of-use'
    expect(page).to have_text('Terms of Use')
  end
end

describe 'e2e Happy Path' do
  before do
    Capybara.page.current_window.resize_to(1200, 800)
    @club = create(:club_with_patrols)
    @patrol1 = @club.patrols.first
  end

  describe 'Member' do
    it 'signs users in and clicks around', js: true do
      @member = create(:member, club: @club, patrol: @patrol1)
      authenticate_user(@member)

      visit '/dashboard'
      expect(page).not_to have_text('Privacy Reminder')
      expect(page).to have_text('NOTICE BOARD')

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

      # Accessing modals fails, don't test this
      # logout
    end
  end

  describe 'Patrol Captain' do
    before do
      @captain = create(:member, club: @club, patrol: @patrol1, position: 'Patrol Captain')
    end

    it 'views Sign-on Sheet' do
      authenticate_user(@captain)

      visit '/dashboard'
      expect(page).to have_text('Privacy Reminder')

      visit '/rosters'

      click_on('View', match: :first)
      expect(page).to have_text('Final Roster')

      new_window = window_opened_by { click_on 'Sign-on Sheet' }
      within_window new_window do
        expect(page).to have_text('Rostered')
      end
      new_window.close

      # Fails to run on TravisCI. May run better on buildKite.
      # new_window = window_opened_by { click_on 'Sign-on Sheet (PDF)' }
      # within_window new_window do
      #   # PDF generation time
      #   sleep(inspection_time=10)
      #   page.save_screenshot
      # end

      # Accessing modals fails, don't test this
      # logout
    end
  end
end
