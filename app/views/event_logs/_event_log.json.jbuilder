# frozen_string_literal: true
json.extract! event_log, :id, :subject, :desc, :created_at, :updated_at
json.url event_log_url(event_log, format: :json)
