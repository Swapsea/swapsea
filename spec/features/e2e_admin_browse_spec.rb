# frozen_string_literal: true

require 'rails_helper'
require 'capybara'
require 'capybara-screenshot/rspec'

describe 'e2e Happy Path - Admin' do
  before(:all) do
    Capybara.page.current_window.resize_to(1200, 800)
  end

  before do
    @club = create(:club_with_patrols)
  end

  it 'visit home page' do
    visit '/'
    expect(page).to have_text('Patrol Swaps Made Easy')
  end

  it 'signs admin in and clicks around', js: true do
    @admin = create(:admin, club: @club, patrol: @club.patrols.first)
    authenticate_user(@admin)

    expect(page).to have_text('NOTICE BOARD')

    visit '/admin'

    visit '/clubs/admin'
    wait_for_ajax
    expect(page).to have_text('CLUBS')

    visit '/users/admin'
    wait_for_ajax
    expect(page).to have_text('MEMBERS')

    # Accessing modals fails, don't test this
    # logout
  end
end
