# frozen_string_literal: true

class HomeController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @lead = Lead.new
    render layout: 'application'
  end

  def thanks
    render layout: 'basic'
  end

  def privacy_policy
    render layout: 'basic'
  end

  def about_us
    render layout: 'basic'
  end

  def terms_of_use
    render layout: 'basic'
  end
end
