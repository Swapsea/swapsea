# frozen_string_literal: true

require 'twilio-ruby'

class SmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    body = params[:Body]
    from = params[:From]
    resp = Twilio::TwiML::MessagingResponse.new do |r|
      case body
      when /start/i
        r.message body: 'Hello from Swapsea!'
      when /whoami/i
        r.message body: "You are #{from}"
      else
        r.message body: 'Say what?'
      end
    end
    render xml: resp.to_s
  end
end
