# frozen_string_literal: true

class AddClubIdToActivities < ActiveRecord::Migration[6.1]
  def change
    change_table :activities do |t|
      t.bigint :club_id
    end
  end
end
