# frozen_string_literal: true

require 'twilio-ruby'

class SwapseaSms
  ACCOUNT_SID = ENV.fetch('TWILIO_ACCOUNT_SID', nil)
  AUTH_TOKEN  = ENV.fetch('TWILIO_AUTH_TOKEN', nil)
  TWILIO_PHONE_NUMBER = ENV.fetch('TWILIO_PHONE_NUMBER', nil)

  def self.roster_reminder(*args)
    new(*args)
  end

  def initialize(*args)
    @user, @next_roster = args
  end

  def deliver
    return unless recipient_number

    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    message = @client.messages.create \
      body: message_body,
      to: recipient_number,
      from: TWILIO_PHONE_NUMBER
  end

  def recipient_number
    if ENV['TESTING_PHONE_NUMBER']
      ENV['TESTING_PHONE_NUMBER']
    elsif Rails.env.development?
      Rails.logger.warn 'SwapseaSms: No number defined for TESTING_PHONE_NUMBER'
      nil
    elsif Rails.env.production? && @user.mobile_phone && @user.smsable?
      @user.mobile_phone
    end
  end

  def message_body
    [
      "Upcoming patrol #{@user.club.name.truncate(26)} (#{@next_roster.patrol.name.truncate(27)})",
      "on #{@next_roster.start.strftime('%a %d %b %y')}",
      "#{@next_roster.start.strftime('%H:%M')}-#{@next_roster.finish.strftime('%H:%M')}.",
      "Can't make it? Swap at swapsea.com.au Reply STOP 2 unsub."
    ].join(' ')
  end
end
