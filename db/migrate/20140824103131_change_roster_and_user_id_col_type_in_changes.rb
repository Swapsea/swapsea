# frozen_string_literal: true

class ChangeRosterAndUserIdColTypeInChanges < ActiveRecord::Migration
  def change
    change_column :swaps, :roster_id, 'integer USING CAST(roster_id AS integer)'
    change_column :swaps, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
