class ChangeRosterColNameKeyToPatrolKey < ActiveRecord::Migration[4.2]
  def change
  	rename_column :rosters, :key, :patrol_key
  end
end
