# frozen_string_literal: true
json.array!(@notices) do |notice|
  json.extract! notice, :id, :title, :desc, :link, :link_desc, :image, :video, :user_id, :club_id, :system_wide, :visible_from, :visible_to, :visible
  json.url notice_url(notice, format: :json)
end
