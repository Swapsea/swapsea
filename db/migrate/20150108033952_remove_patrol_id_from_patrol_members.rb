# frozen_string_literal: true
class RemovePatrolIdFromPatrolMembers < ActiveRecord::Migration
  def change

  	remove_column :patrol_members, :patrol_id, :integer

  end
end
