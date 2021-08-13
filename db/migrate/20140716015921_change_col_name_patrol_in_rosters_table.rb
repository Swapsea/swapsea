# frozen_string_literal: true

class ChangeColNamePatrolInRostersTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :rosters, :patrol, :patrol_name
  end
end
