# frozen_string_literal: true

class AddIndexToActivitiesClubId < ActiveRecord::Migration[6.1]
  def change
    add_index :activities, :club_id
  end
end
