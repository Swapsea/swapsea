# frozen_string_literal: true

class SwapseaMailer < ApplicationMailer
  layout 'mailer'
  # Sent to all users with a patrol in the next 7 days.
  def roster_reminder(user, next_roster, following_roster, subject)
    @user = user
    @next_roster = next_roster
    @following_roster = following_roster
    @subject = subject
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to all users with a proficiency in the next 7 days.
  def proficiency_reminder(user, proficiency)
    @user = user
    @proficiency = proficiency
    @subject = 'Upcoming Skills Maintenance'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to offer user to confirm swap details.
  def offer_successful(offer)
    @offer = offer
    @user = offer.user
    @request = offer.request
    @subject = 'Swap confirmed'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name),
         reply_to: email_address_with_name(@request.user.email, @request.user.name)
  end

  # Sent to offer user to confirm swap details.
  def offer_unsuccessful(offer)
    @offer = offer
    @user = offer.user
    @request = offer.request
    @subject = 'Offer unsuccessful'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to offer user to notify them that their offer was declined.
  def offer_declined(offer, decline_remark)
    @offer = offer
    @user = offer.user
    @request = offer.request
    @decline_remark = decline_remark
    @subject = 'Offer declined'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to request user to notify them that the offer was cancelled by the offer user.
  def offer_cancelled(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    @subject = 'Offer cancelled'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to request user to notify them that they have received an offer.
  def offer_received(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    @subject = 'Offer received'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to request user to notify them that the offer was accepted elsewhere or a request with identical detail was successful.
  def offer_closed(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    @subject = 'Offer closed'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to request user to confirm swap request created.
  def request_created(request)
    @request = request
    @user = request.user
    @subject = 'Request created'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to request user to confirm swap details.
  def request_successful(request)
    @request = request
    @user = request.user
    @offer = request.accepted_offer
    @subject = 'Swap confirmed'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name),
         reply_to: email_address_with_name(@offer.user.email, @offer.user.name)
  end

  def request_nudge_offers(request, other_request_dates)
    @request = request
    @user = request.user
    @other_request_dates = other_request_dates
    @subject = "Make an offer for #{request.roster.start.strftime('%A, %d %B')}"
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to each offer user to notify them that the request was cancelled
  def request_cancelled(offer)
    @request = offer.request
    @offer = offer
    @user = offer.user
    @subject = 'Request cancelled'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Sent to the offer user to notify them that the request was closed because it has been accepted as an offer elsewhere.
  def request_closed(offer)
    @request = offer.request
    @offer = offer
    @user = offer.user
    @subject = 'Request closed'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  def welcome_email(user)
    @user = user
    @subject = 'Activate your Swapsea account for 2022/23'
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  # Email a link to PDF of next roster
  def patrol_report(user, next_roster)
    @user = user
    @roster = next_roster
    @subject = "#{next_roster.patrol.short_name.presence || next_roster.patrol.name} - #{next_roster.start.strftime('%a %d %b %y %H:%M')}-#{next_roster.finish.strftime('%H:%M')}"
    # Send Email
    mail subject: @subject,
         to: email_address_with_name(@user.email, @user.name)
  end

  ###############################################################################
  # => To consolidate
  ###############################################################################

  def north_bondi_not_yet_proficient(user)
    @user = user
    mail subject: 'Sign Up for Skills Maintenance',
         to: email_address_with_name(@user.email, @user.name)
  end
end
