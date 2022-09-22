# frozen_string_literal: true

class OutreachPatrol < ApplicationRecord
  belongs_to :club
  has_many :outreach_patrol_sign_ups
  has_many :users, through: :outreach_patrol_sign_ups

  scope :with_club, ->(club_id) { where(club_id:).includes(:club) }
end
