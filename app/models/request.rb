# frozen_string_literal: true

class Request < ApplicationRecord
  include PublicActivity::Common

  belongs_to :roster
  belongs_to :user
  has_many :offers

  scope :with_status_open, lambda { |organisation|
                             includes(:roster, :user, :offers, roster: [:patrol]).where('rosters.start > ? AND requests.status = ? AND rosters.organisation = ?',
                                                                                        DateTime.now - 3.hours, 'open', organisation).order('rosters.start')
                           }

  def offer_already_exists?(roster, user)
    offers.where(user:, roster:, status: 'pending').present?
  end

  def accepted_offer
    offers.where(status: 'accepted').first if offers.where(status: 'accepted').present?
  end

  def offers_with_status(status)
    Offer.where('request_id = ? AND status = ?', id, status)
  end

  def unsuccessful_offers(successful_offer)
    Offer.where('request_id = ? AND status = ? AND id != ?', id, 'pending', successful_offer)
  end

  def corresponding_offers
    Offer.where('roster_id = ? AND user_id = ? AND status = ?', roster_id, user_id, 'pending')
  end

  def close
    # closes offers for this request
    offers = offers_with_status('pending')
    offers.each do |o|
      o.status = 'removed'
      if o.save
        SwapseaMailer.request_closed(o).deliver
      else
        raise 'Error accepting offer. (Code 3)'
      end
    end
  end

  def offers_that_match_request
    Offer.where('roster_id = ? AND user_id =? AND status = ?', roster_id, user_id, 'pending')
  end
end
