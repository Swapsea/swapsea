# frozen_string_literal: true

class Notice < ApplicationRecord
  belongs_to :club
  belongs_to :user
  has_many :notice_acknowledgements

  scope :with_club, ->(club_id) { where(club_id:).or(system_wide: 1).includes(:club) }
  scope :with_visible, -> { where(visible: true) }
  scope :with_invisible, -> { where(visible: false) }

  # visible, current notices
  def self.visible
    Notice.where('visible = true AND visible_from <= ? AND visible_to >= ?', DateTime.now, DateTime.now)
  end
end
