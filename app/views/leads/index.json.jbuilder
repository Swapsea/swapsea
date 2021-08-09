# frozen_string_literal: true
json.array!(@leads) do |lead|
  json.extract! lead, :id, :name, :email, :organisation
  json.url lead_url(lead, format: :json)
end
