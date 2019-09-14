class Offer < ActiveRecord::Base

	include PublicActivity::Common

	belongs_to :request
	belongs_to :user
	belongs_to :roster

	# Returns array of offers for the same rostered patrol.
	def requests
		Offer.where(:roster => roster)
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