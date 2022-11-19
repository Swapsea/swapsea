# frozen_string_literal: true

class Offer < ApplicationRecord
  include PublicActivity::Common

  belongs_to :request
  belongs_to :user
  belongs_to :roster

  scope :with_club, ->(club_id) { joins(:request, :user, :roster).where(users: { club_id: }).includes(:request, :user, :roster) }
  scope :with_offered_by, ->(user_id) { joins(:request, :user, :roster, roster: :patrol).where(user_id:).includes(:request, :user, :roster, roster: :patrol) }
  scope :with_pending_status, -> { joins(:roster).where(status: 'pending').where('start > ?', DateTime.now) }
  scope :with_accepted_status, -> { where(status: 'accepted') }

  after_initialize :set_defaults

  def set_defaults
    self.status = :pending
  end

  def pending?
    if valid?
      status == 'pending' && roster.start > DateTime.now
    else
      false
    end
  end

  # Returns array of offers for the same rostered patrol.
  def requests
    Offer.where(roster:)
  end

  def decline(remark)
    self.status = :declined
    self.decline_remark = remark
    save
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
    self.status = :cancelled
    save
  end

  def unsuccessful
    self.status = :unsuccessful
    save
  end

  # Returns array of offers for the same rostered patrol for the same user, made to other requests.
  def same_offer_for_other_requests
    Offer.where('roster_id = ? AND user_id = ? AND id != ? AND status = ?', roster.id, user.id, id, 'pending')
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
