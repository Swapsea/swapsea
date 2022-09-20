# frozen_string_literal: true

class Club < ApplicationRecord
  has_many :patrols, -> { order('name ASC') }, foreign_key: 'organisation', primary_key: 'name'
  has_many :patrol_members, through: :patrols
  has_many :rosters, through: :patrols
  has_many :requests, through: :rosters
  has_many :users, through: :patrol_members
  has_many :awards, through: :users
  has_many :proficiencies
  has_many :outreach_patrols
  has_many :notices

  scope :show_patrols, -> { where(show_patrols: true) }
  scope :with_status_active, -> { where(is_active: true) }
  scope :with_reminder_emails_enabled, -> { where(is_active: true, enable_reminders_email: true) }
  scope :with_reminder_sms_enabled, -> { where(is_active: true, enable_reminders_sms: true) }
end
