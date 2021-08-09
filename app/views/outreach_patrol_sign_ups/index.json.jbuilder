# frozen_string_literal: true
json.array!(@outreach_patrol_sign_ups) do |outreach_patrol_sign_up|
  json.extract! outreach_patrol_sign_up, :id, :user_id, :outreach_patrol_id
  json.url outreach_patrol_sign_up_url(outreach_patrol_sign_up, format: :json)
end
