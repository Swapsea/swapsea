# frozen_string_literal: true
json.array!(@rosters) do |roster|
  json.extract! roster, :id, :organisation, :patrol, :key, :start, :finish
  json.url roster_url(roster, format: :json)
end
