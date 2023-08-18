# frozen_string_literal: true

class DashboardController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @notices = Notice.visible

    @my_roster = selected_user.custom_roster
    @my_patrol = selected_user.patrol

    # @activities = PublicActivity::Activity.where(club: selected_user.club).limit(10).order('created_at desc')

    @confirmed_offers = Offer.with_club(selected_user.club_id).includes(:user, request: %i[user roster]).with_accepted_status.order(updated_at: :desc).limit(3)

    render layout: 'dashboard'
  end
end
