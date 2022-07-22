# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  # Autoload classes and modules needed at boot time here.
  ActionMailer::Base.class_eval do
    include EmailLoggingAfterFilter
  end
end
