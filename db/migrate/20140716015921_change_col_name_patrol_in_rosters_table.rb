class ChangeColNamePatrolInRostersTable < ActiveRecord::Migration
  def change
  	rename_column :rosters, :patrol, :patrol_name
  end
end
