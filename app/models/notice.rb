# frozen_string_literal: true

class Notice < ActiveRecord::Base
  belongs_to :club, foreign_key: :organisation, primary_key: :name
  belongs_to :user
  has_many :notice_acknowledgements

  # visible, current notices
  def self.visible
    Notice.where('visible = true AND visible_from <= ? AND visible_to >= ?', DateTime.now, DateTime.now)
  end
end
