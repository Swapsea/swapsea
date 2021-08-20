# frozen_string_literal: true

class RemovePatrolKeyReplaceWithShortName < ActiveRecord::Migration[5.0]
  def change
    remove_column :patrols, :key, :string
    add_column :patrols, :short_name, :string

    remove_column :patrol_members, :patrol_key, :string
    add_column :patrol_members, :patrol_name, :string

    add_column :users, :patrol_name, :string
    add_column :users, :default_position, :string

    remove_column :rosters, :patrol_key, :string
  end
end
