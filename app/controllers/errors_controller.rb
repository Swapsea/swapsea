# frozen_string_literal: true

class ErrorsController < ApplicationController
  def show
    @exception = env['action_dispatch.exception']
    render status_code.to_s, status: status_code, layout: 'blank'
  end

  protected

  def status_code
    request.path[1..-1] || 500
  end
end
