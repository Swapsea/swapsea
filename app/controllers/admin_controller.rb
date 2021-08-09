# frozen_string_literal: true

class AdminController < ApplicationController
  load_and_authorize_resource class: false

  def index; end
end
