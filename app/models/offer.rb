# frozen_string_literal: true

class Offer < ApplicationRecord
  include PublicActivity::Common

  belongs_to :request
  belongs_to :user
  belongs_to :roster

  scope :with_club, ->(club_id) { joins(:request, :user).left_joins(:roster).where(users: { club_id: }).includes(:request, :user, :roster) }
  scope :with_offered_by, ->(user_id) { joins(:request, :user).left_joins(:roster, roster: :patrol).includes(:request, :user, :roster, request: [:user, :roster, { roster: :patrol }], roster: :patrol).where(user_id:) }
  scope :with_pending_status, -> { left_joins(:roster).where(status: :pending).where('rosters.finish > ? OR rosters.finish IS NULL', DateTime.now) }
  scope :with_accepted_status, -> { joins(:request, :user).left_joins(:roster).where(status: 'accepted') }

  after_initialize :set_defaults

  def set_defaults
    self.status = :pending unless status
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
    status == 'pending' && offered_roster_valid?
  end

  def unsuccessful?
    status == 'unsuccessful'
  end

  def withdrawn?
    status == 'withdrawn'
  end

  def offered_roster_valid?
    # No roster for substitute, or future roster
    !roster || roster.start > DateTime.now
  end

  # Returns array of offers for the same rostered patrol.
  def requests
    Offer.where(roster:)
  end

  def accept
    # Check valid status
    case status
    when 'cancelled', 'declined', 'unsuccessful', 'withdrawn', 'accepted'
      message = "Error: Offer '#{id}' cannot be accepted from status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      return false
    end

    # Acceptable Offer?
    unless request.open?
      message = "Error Accepting Offer: '#{id}': Request not open."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      return false
    end

    unless offered_roster_valid?
      message = "Error Accepting Offer: '#{id}': Offer in the past cannot be accepted."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      return false
    end

    trans_id = Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)

    # Remove requestor from old roster
    @swap_requestor_off = Swap.new
    @requestor_uniq_id = Swap.where(user_id: request.user.id, roster_id: request.roster.id).first
    @requestor_uniq_id = if @requestor_uniq_id.present?
                           @requestor_uniq_id.uniq_id
                         else
                           Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)
                         end
    @swap_requestor_off.trans_id = trans_id
    @swap_requestor_off.uniq_id = @requestor_uniq_id
    @swap_requestor_off.roster_id = request.roster.id
    @swap_requestor_off.user_id = request.user.id
    @swap_requestor_off.on_off_patrol = false

    # Remove offerer from old roster
    @swap_offerer_off = Swap.new
    @offerer_uniq_id = Swap.where(user_id: user.id, roster_id: roster&.id).first
    @offerer_uniq_id = if @offerer_uniq_id.present?
                         @offerer_uniq_id.uniq_id
                       else
                         Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)
                       end
    @swap_offerer_off.trans_id = trans_id
    @swap_offerer_off.uniq_id = @offerer_uniq_id
    @swap_offerer_off.roster_id = roster&.id
    @swap_offerer_off.user_id = user.id
    @swap_offerer_off.on_off_patrol = false

    # Add requestor to new roster
    @swap_requestor_on = Swap.new
    @swap_requestor_on.trans_id = trans_id
    @swap_requestor_on.uniq_id = @offerer_uniq_id
    @swap_requestor_on.roster_id = roster&.id
    @swap_requestor_on.user_id = request.user.id
    @swap_requestor_on.on_off_patrol = true

    # Add offerer to new roster
    @swap_offerer_on = Swap.new
    @swap_offerer_on.trans_id = trans_id
    @swap_offerer_on.uniq_id = @requestor_uniq_id
    @swap_offerer_on.roster_id = request.roster.id
    @swap_offerer_on.user_id = user.id
    @swap_offerer_on.on_off_patrol = true

    self.status = :accepted

    begin
      transaction do
        unless request.succeeded
          message = "Error Accepting Offer: '#{id}': Unable to mark request as successful."
          Rails.logger.warn message
          EventLog.create!(subject: 'Warning', desc: message)
          Raise ActiveRecord::RecordNotSaved
        end

        @swap_requestor_off.save!
        @swap_offerer_off.save!
        @swap_requestor_on.save!
        @swap_offerer_on.save!

        # Save this offer
        save!

        #
        # REFACTOR THESE IN TO METHODS
        #
        # 1) Withdraw same offer made to other requests.
        same_offer_for_other_requests.map do |other_offer|
          Rails.logger.debug { "same_offer_for_other_requests: Withdrawing other_offer '#{other_offer.id}'" }
          next if other_offer.withdraw

          message = "Error Accepting Offer: '#{id}': Offer '#{other_offer.id}' for other requests cannot be withdrawn."
          Rails.logger.warn message
          EventLog.create!(subject: 'Warning', desc: message)
          Raise ActiveRecord::RecordNotSaved
        end

        # 2) Unsuccessful offers.
        other_offers_for_the_same_request.map do |other_offer|
          Rails.logger.debug { "other_offers_for_the_same_request: unsuccessful other_offer '#{other_offer.id}'" }
          next if other_offer.unsuccessful

          message = "Error Accepting Offer: '#{id}': Offer '#{other_offer.id}' cannot be marked unsuccessful."
          Rails.logger.warn message
          EventLog.create!(subject: 'Warning', desc: message)
          Raise ActiveRecord::RecordNotSaved
        end

        # 3) Cancel requests for accepted offer.
        corresponding_requests.map do |corresponding_request|
          Rails.logger.debug { "corresponding_requests: cancelled corresponding_request '#{corresponding_request.id}'" }
          next if corresponding_request.cancel

          message = "Error Accepting Offer: '#{id}': Request '#{corresponding_request.id}' cannot be cancelled."
          Rails.logger.warn message
          EventLog.create!(subject: 'Warning', desc: message)
          Raise ActiveRecord::RecordNotSaved
        end

        # 4) Withdraw offers that match successful Request
        request.offers_that_match_request.map do |corresponding_offer|
          Rails.logger.debug { "offers_that_match_request: Withdrawing corresponding_offer '#{corresponding_offer.id}'" }
          next if corresponding_offer.withdraw

          message = "Error Accepting Offer: '#{id}': Offer '#{corresponding_offer.id}' cannot be withdrawn."
          Rails.logger.warn message
          EventLog.create!(subject: 'Warning', desc: message)
          Raise ActiveRecord::RecordNotSaved
        end
      end
    rescue ActiveRecord::RecordNotSaved
      message = "Error Accepting Offer: '#{id}': RecordNotSaved."
      Rails.logger.error message
      EventLog.create!(subject: 'Error', desc: message)
      return false
    end

    # Update counts
    request.roster.update_award_counts
    roster&.update_award_counts
    true
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
      message = "Error: Cannot decline offer '#{id}' with status '#{status}'."
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
      message = "Error: Cannot withdraw offer '#{id}' with status '#{status}'."
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
      message = "Error: Cannot cancel offer '#{id}' with status '#{status}'."
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
      message = "Error: Cannot set status of offer '#{id}' to unsuccessful with status '#{status}'."
      Rails.logger.warn message
      EventLog.create!(subject: 'Warning', desc: message)
      false
    end
  end

  # Returns array of offers for the same rostered patrol for the same user, made to other requests.
  def same_offer_for_other_requests
    if roster.present?
      Offer.with_pending_status.with_offered_by(user.id).where.not(id:).where(roster_id: roster&.id)
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
