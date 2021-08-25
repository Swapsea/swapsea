# frozen_string_literal: true

class ErrorsController < ApplicationController
  def show
    @exception = request.env['action_dispatch.exception']
    render template: "errors/#{status_code}", status: status_code
  end

  protected

  def status_code
    request.path[1..] || 500
  end
end
