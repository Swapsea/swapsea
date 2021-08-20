# frozen_string_literal: true

class ChangeRosterColNameKeyToPatrolKey < ActiveRecord::Migration[5.0]
  def change
    rename_column :rosters, :key, :patrol_key
  end
end
