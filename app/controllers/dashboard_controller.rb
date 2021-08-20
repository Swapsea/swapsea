# frozen_string_literal: true

class DashboardController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @notices = Notice.visible

    @my_roster = selected_user.custom_roster
    @my_patrol = selected_user.patrol

    @activities = PublicActivity::Activity.order('created_at desc').limit(10)

    @confirmed_offers = Offer.includes(:user, :roster, request: [:user, :roster]).joins(:roster).where('offers.status = ? AND rosters.organisation = ?', 'accepted',
                                                   selected_user.organisation).order(updated_at: :desc).limit(3)

    render layout: 'dashboard'
  end
end
