class ChangeRosterColNameKeyToPatrolKey < ActiveRecord::Migration
  def change
  	rename_column :rosters, :key, :patrol_key
  end
end
