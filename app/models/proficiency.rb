# frozen_string_literal: true

class Proficiency < ApplicationRecord
  belongs_to :club
  has_many :proficiency_signups
  has_many :users, through: :proficiency_signups

  scope :with_club, ->(club_id) { where(club_id:) }
end
