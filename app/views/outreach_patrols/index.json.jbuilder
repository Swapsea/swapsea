# frozen_string_literal: true
json.array!(@outreach_patrols) do |outreach_patrol|
  json.extract! outreach_patrol, :id, :location, :start, :finish
  json.url outreach_patrol_url(outreach_patrol, format: :json)
end
