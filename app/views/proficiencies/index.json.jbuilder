# frozen_string_literal: true
json.array!(@proficiencies) do |proficiency|
  json.extract! proficiency, :id, :name, :start, :finish, :max_signup, :max_online_signup
  json.url proficiency_url(proficiency, format: :json)
end
