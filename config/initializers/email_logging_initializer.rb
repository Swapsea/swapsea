# frozen_string_literal: true

ActionMailer::Base.class_eval do
  include EmailLoggingAfterFilter
end
