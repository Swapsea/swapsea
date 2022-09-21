# frozen_string_literal: true

class AddPatrolRefToRoster < ActiveRecord::Migration[6.0]
  def change
    add_reference :rosters, :patrol, foreign_key: true
    execute <<-SQL.squish
      UPDATE rosters r
      SET patrol_id = p.id
      FROM patrols p
      WHERE r.patrol_name = p.name AND r.organisation = p.organisation;
    SQL
    remove_column :rosters, :organisation, :string
    remove_column :rosters, :patrol_name, :string
  end
end
