# frozen_string_literal: true

class DashboardController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @notices = Notice.visible

    @my_roster = selected_user.custom_roster
    @my_patrol = selected_user.patrol

    @activities = PublicActivity::Activity.order('created_at desc').limit(10)

    @confirmed_offers = Offer.with_club(selected_user.club_id).includes(:user, :roster, request: %i[user roster]).joins(:roster).where(status: 'accepted').order(updated_at: :desc).limit(3)

    render layout: 'dashboard'
  end
end
