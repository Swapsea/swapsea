class ChangeColNamePatrolInRostersTable < ActiveRecord::Migration[4.2]
  def change
  	rename_column :rosters, :patrol, :patrol_name
  end
end
