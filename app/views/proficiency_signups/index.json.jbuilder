# frozen_string_literal: true
json.array!(@proficiency_signups) do |proficiency_signup|
  json.extract! proficiency_signup, :id, :user_id, :proficiency_id
  json.url proficiency_signup_url(proficiency_signup, format: :json)
end
