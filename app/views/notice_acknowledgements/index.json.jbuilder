# frozen_string_literal: true

json.array!(@notice_acknowledgements) do |notice_acknowledgement|
  json.extract! notice_acknowledgement, :id, :user_id, :notice_id
  json.url notice_acknowledgement_url(notice_acknowledgement, format: :json)
end
