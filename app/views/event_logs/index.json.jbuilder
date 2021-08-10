# frozen_string_literal: true

json.array! @event_logs, partial: 'event_logs/event_log', as: :event_log
