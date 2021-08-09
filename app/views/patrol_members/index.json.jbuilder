# frozen_string_literal: true
json.array!(@patrol_members) do |patrol_member|
  json.extract! patrol_member, :id, :user_id, :patrol_id, :patrol_key, :default_position
  json.url patrol_member_url(patrol_member, format: :json)
end
