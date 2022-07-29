# frozen_string_literal: true

class HomeController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @lead = Lead.new
    render layout: 'application'
  end

  def setup
    render layout: 'blank'
  end

  def faq
    render layout: 'blank'
  end

  def contact_us
    render layout: 'blank'
  end

  def terms_of_use
    render layout: 'blank'
  end

  def thanks
    render layout: 'basic'
  end

  def privacy_policy
    render layout: 'basic'
  end
end
