require 'twilio-ruby'

class SwapseaSms
  ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  AUTH_TOKEN  = ENV['TWILIO_AUTH_TOKEN']
  TWILIO_PHONE_NUMBER  = ENV['TWILIO_PHONE_NUMBER']
  TESTING_PHONE_NUMBER = ENV['TESTING_PHONE_NUMBER']

  def self.weekly_roster *args
    new *args
  end

  def initialize *args
    @user, @next_roster = args
  end

  def deliver
    if recipient_number
      @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
      message = @client.messages.create \
        body: message_body,
        to: recipient_number,
        from: TWILIO_PHONE_NUMBER
    end
  end

  private


  def recipient_number
    if TESTING_PHONE_NUMBER
      TESTING_PHONE_NUMBER
    elsif Rails.env.development?
      Rails.logger.warn 'SwapseaSms: No number defined for TESTING_PHONE_NUMBER'
      nil
    elsif Rails.env.production? && @user.mobile_phone && @user.smsable?
      @user.mobile_phone
    end
  end

  def message_body
    [
      "Upcoming patrol #{@user.organisation} \"#{@next_roster.patrol_name}\"",
      "on #{@next_roster.start.strftime("%a %d %b %y")},",
      "#{@next_roster.start.strftime("%H:%M")} -",
      "#{@next_roster.finish.strftime("%H:%M")}.",
      "Can't make it? Swap at www.swapsea.com.au.",
      "Reply STOP to unsubscribe."
    ].join(' ')
  end
end
