# frozen_string_literal: true

class Request < ApplicationRecord
  include PublicActivity::Common

  belongs_to :roster
  belongs_to :user
  has_many :offers

  scope :with_club, ->(club_id) { joins(:roster, :user).where(users: { club_id: }).includes(:roster, :user, :offers, roster: [:patrol]) }
  scope :with_roster, ->(roster_id) { joins(:roster, :user).where(roster_id:).includes(:roster, :user, :offers, roster: [:patrol]) }
  scope :with_requested_by, ->(user_id) { where(user_id:) }
  scope :with_successful_status, -> { where(status: 'successful') }
  scope :with_open_status, -> { joins(:roster).where(status: 'open').where('finish > ?', DateTime.now) }
  attr_readonly :nudge_email_opt_out_date

  after_initialize :set_defaults

  def set_defaults
    self.status = :open unless status
  end

  def cancelled?
    status == 'cancelled'
  end

  def open?
    status == 'open'
  end

  def successful?
    status == 'successful'
  end

  def accepted_offer
    offers.where(status: 'accepted').first if offers.where(status: 'accepted').present?
  end

  def offer_already_exists?(roster, user)
    offers.with_pending_status.where(roster:, user:).present?
  end

  def unsuccessful_offers(successful_offer)
    Offer.where('request_id = ? AND status = ? AND id != ?', id, 'pending', successful_offer)
  end

  # Cancel request and any pending offers.
  def cancel
    self.status = :cancelled
    if save
      offers.with_pending_status.each do |pending_offer|
        if pending_offer.cancel
          # SwapseaMailer.request_cancelled(offer).deliver
        end
      end
    else
      false
    end
  end

  def succeeded
    # Check valid status
    case status
    when 'successful'
      # Already successful
      true
    when 'open'
      self.status = :successful
      save
    else
      message = "Request '#{id}' cannot be successful from status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  def accepted_offer
    offers.where(status: 'accepted').first if offers.where(status: 'accepted').present?
  end

  def unsuccessful_offers(successful_offer)
    Offer.where('request_id = ? AND status = ? AND id != ?', id, 'pending', successful_offer)
  end

  def offers_that_match_request
    if roster_id?
      Offer.with_pending_status.with_offered_by(user_id).where(roster_id:)
    else
      []
    end
  end

  def self.nudge_email_opt_out=(opt_out)
    self.nudge_email_opt_out_date = (DateTime.now if opt_out)
    save!
  end
end
