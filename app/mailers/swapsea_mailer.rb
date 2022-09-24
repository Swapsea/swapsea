# frozen_string_literal: true

class SwapseaMailer < ApplicationMailer
  # Sent to all users with a patrol in the next 7 days.
  def roster_reminder(user, next_roster, following_roster, subject)
    @user = user
    @subject = subject
    @next_roster = next_roster
    @following_roster = following_roster
    mail subject: @subject,
         to: user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to all users with a proficiency in the next 7 days.
  def proficiency_reminder(user, proficiency)
    @user = user
    @proficiency = proficiency
    mail subject: 'Upcoming Skills Maintenance',
         to: @user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to offer user to confirm swap details.
  def offer_successful(offer)
    @offer = offer
    @user = offer.user
    @request = offer.request
    mail subject: 'Swap confirmed',
         to: offer.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>',
         reply_to: offer.request.user.email
  end

  # Sent to offer user to confirm swap details.
  def offer_unsuccessful(offer)
    @offer = offer
    @user = offer.user
    @request = offer.request
    mail subject: 'Offer unsuccessful',
         to: offer.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to offer user to notify them that their offer was declined.
  def offer_declined(offer)
    @offer = offer
    @user = offer.user
    @request = offer.request
    mail subject: 'Offer declined',
         to: offer.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to request user to notify them that the offer was cancelled by the offer user.
  def offer_cancelled(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    mail subject: 'Offer cancelled',
         to: offer.request.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to request user to notify them that they have received an offer.
  def offer_received(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    mail subject: 'Offer received',
         to: offer.request.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to request user to notify them that the offer was accepted elsewhere or a request with identical detail was successful.
  def offer_closed(offer)
    @offer = offer
    @user = offer.request.user
    @request = offer.request
    mail subject: 'Offer closed',
         to: offer.request.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to request user to confirm swap details.
  def request_successful(request)
    @request = request
    @user = request.user
    @offer = request.accepted_offer
    mail subject: 'Swap confirmed',
         to: request.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>',
         reply_to: request.accepted_offer.user.email
  end

  def request_nudge_offers(request, other_request_dates)
    @request = request
    @user = request.user
    @other_request_dates = other_request_dates
    mail subject: 'Make an offer for ' + request.roster.start.strftime('%A, %d %B'),
         to: request.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to each offer user to notify them that the request was cancelled
  def request_cancelled(offer)
    @request = offer.request
    @offer = offer
    @user = offer.user
    mail subject: 'Request cancelled',
         to: offer.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  # Sent to the offer user to notify them that the request was closed because it has been accepted as an offer elsewhere.
  def request_closed(offer)
    @request = offer.request
    @offer = offer
    @user = offer.user
    mail subject: 'Request closed',
         to: offer.user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  def welcome_email(user)
    @user = user
    mail subject: 'Activate your Swapsea account for 2022/23',
         to: user.email,
         from: 'Swapsea <help@swapsea.com.au>'
  end

  def activity(subject, message)
    @subject = subject
    @message = message
    mail subject: @subject,
         to: 'Alex <alex@swapsea.com.au>',
         from: 'Swapsea <help@swapsea.com.au>'
  end

  ###############################################################################
  # => To consolidate
  ###############################################################################

  def north_bondi_not_yet_proficient(user)
    @user = user
    mail subject: 'Sign Up for Skills Maintenance',
         to: @user.email,
         from: 'Swapsea <noreply@swapsea.com.au>'
  end

  def north_bondi_patrol_report(roster)
    @roster = roster
    # Collect PC and VC Emails
    to = []
    roster.patrol.patrol_captains&.each do |pc|
      to << pc
    end
    roster.patrol.vice_captains&.each do |vc|
      to << vc
    end

    # Send Email
    mail subject: "#{roster.patrol.short_name.presence || roster.patrol.name} - #{roster.start.strftime('%a %d %b %y %H:%M')}-#{roster.finish.strftime('%H:%M')}",
         to: to.collect(&:email).join(','),
         cc: 'office@northbondisurfclub.com, captain@northbondisurfclub.com, vicecaptain@northbondisurfclub.com, alex@swapsea.com.au',
         from: 'Swapsea <help@swapsea.com.au>'
  end

  def bronte_patrol_report(roster)
    @roster = roster
    # Collect PC and VC Emails
    to = []
    roster.patrol.patrol_captains&.each do |pc|
      to << pc
    end
    roster.patrol.vice_captains&.each do |vc|
      to << vc
    end

    # Send Email
    mail subject: "#{roster.patrol.short_name.presence || roster.patrol.name} - #{roster.start.strftime('%a %d %b %y %H:%M')}-#{roster.finish.strftime('%H:%M')}",
         to: to.collect(&:email).join(','),
         from: 'Swapsea <help@swapsea.com.au>'
  end
end
