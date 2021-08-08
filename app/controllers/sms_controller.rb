require 'twilio-ruby'

class SmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    body, from = params[:Body], params[:From]
    resp = Twilio::TwiML::MessagingResponse.new do |r|
      if body =~ /start/i
        r.message body: 'Hello from Swapsea!'
      elsif body =~ /whoami/i
        r.message body: "You are #{from}"
      else
        r.message body: 'Say what?'
      end
    end
    render xml: resp.to_s
  end
end
