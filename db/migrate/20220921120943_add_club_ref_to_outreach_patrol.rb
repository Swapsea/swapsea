# frozen_string_literal: true

class AddClubRefToOutreachPatrol < ActiveRecord::Migration[6.0]
  def up
    add_reference :outreach_patrols, :club, foreign_key: true
    execute <<-SQL.squish
      UPDATE outreach_patrols op
      SET club_id = c.id
      FROM clubs c
      WHERE op.organisation = c.name;
    SQL
    remove_column :outreach_patrols, :organisation, :string
  end
end
