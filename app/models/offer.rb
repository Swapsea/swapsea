# frozen_string_literal: true

class Offer < ApplicationRecord
  include PublicActivity::Common

  belongs_to :request
  belongs_to :user
  belongs_to :roster

  scope :with_club, ->(club_id) { joins(:request, :user, :roster).where(users: { club_id: }).includes(:request, :user, :roster) }
  scope :with_offered_by, ->(user_id) { joins(:request, :user, :roster, roster: :patrol).where(user_id:).includes(:request, :user, :roster, roster: :patrol) }
  scope :with_pending_status, -> { left_joins(:roster).where(status: :pending).where('finish > ? OR finish IS NULL', DateTime.now) }
  scope :with_accepted_status, -> { where(status: 'accepted') }

  after_initialize :set_defaults

  def set_defaults
    self.status = :pending
  end

  def accepted?
    status == 'accepted'
  end

  def cancelled?
    status == 'cancelled'
  end

  def declined?
    status == 'declined'
  end

  def pending?
    status == 'pending' && roster.start > DateTime.now
  end

  def unsuccessful?
    status == 'unsuccessful'
  end

  def withdrawn?
    status == 'withdrawn'
  end

  # Returns array of offers for the same rostered patrol.
  def requests
    Offer.where(roster:)
  end

  def decline(remark = nil)
    case status
    when 'declined'
      # Already declined
      true
    when 'pending'
      self.status = :declined
      self.decline_remark = remark
      save
    else
      message = "Cannot decline offer '#{id}' with status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  def withdraw
    case status
    when 'withdrawn'
      # Already withdrawn
      true
    when 'pending'
      self.status = :withdrawn
      save
    else
      message = "Cannot withdraw offer '#{id}' with status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  def cancel
    case status
    when 'cancelled'
      # Already cancelled
      true
    when 'pending'
      self.status = :cancelled
      save
    else
      message = "Cannot cancel offer '#{id}' with status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  def unsuccessful
    case status
    when 'unsuccessful'
      # Already unsuccessful
      true
    when 'pending'
      self.status = :unsuccessful
      save
    else
      message = "Cannot set status of offer '#{id}' to unsuccessful with status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  # Returns array of offers for the same rostered patrol for the same user, made to other requests.
  def same_offer_for_other_requests
    if roster.present?
      Offer.with_pending_status.with_offered_by(user.id).with_roster(roster.id).where.not(id:)
    else
      []
    end
  end

  # Returns array of other offers for the same request as this offer.
  def other_offers_for_the_same_request
    Offer.where('request_id = ? AND id != ? AND status = ?', request.id, id, 'pending')
  end

  # Returns array of other requests that the user has made the same offer to, and the request status is still open.
  def corresponding_requests
    Request.where('id != ? AND user_id = ? AND roster_id = ? AND status = ?', request.id, user.id, roster_id, 'open')
  end
end
