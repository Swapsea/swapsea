class ChangeRosterAndUserIdColTypeInChanges < ActiveRecord::Migration[4.2]
  def change
  	change_column :swaps, :roster_id, 'integer USING CAST(roster_id AS integer)'
  	change_column :swaps, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
