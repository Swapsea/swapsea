# frozen_string_literal: true

class RemovePatrolIdFromPatrolMembers < ActiveRecord::Migration[5.0]
  def change
    remove_column :patrol_members, :patrol_id, :integer
  end
end
