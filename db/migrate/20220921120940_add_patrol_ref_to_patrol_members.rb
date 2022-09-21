# frozen_string_literal: true

class AddPatrolRefToPatrolMembers < ActiveRecord::Migration[6.0]
  def change
    add_reference :patrol_members, :patrol, foreign_key: true
    execute <<-SQL.squish
      UPDATE patrol_members pm
      SET patrol_id = p.id
      FROM patrols p
      WHERE pm.patrol_name = p.name AND pm.organisation = p.organisation;
    SQL
    remove_column :patrol_members, :organisation, :string
    remove_column :patrol_members, :patrol_name, :string
  end
end
