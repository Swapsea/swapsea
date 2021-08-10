# frozen_string_literal: true

json.extract! @notice, :id, :title, :desc, :link, :link_desc, :image, :video, :user_id, :club_id, :system_wide,
              :visible_from, :visible_to, :visible, :created_at, :updated_at
