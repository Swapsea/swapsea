json.array!(@clubs) do |club|
  json.extract! club, :id, :name, :short_name, :patrols, :rosters, :swaps, :outreach, :skills_maintenance, :secret
  json.url club_url(club, format: :json)
end
