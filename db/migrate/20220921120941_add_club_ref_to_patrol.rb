class AddClubRefToPatrol < ActiveRecord::Migration[6.0]
  def change
    add_reference :patrols, :club, foreign_key: true
    execute <<-SQL
      UPDATE patrols p
      SET club_id = c.id
      FROM clubs c
      WHERE p.organisation = c.name;
    SQL
    remove_column :patrols, :organisation, :string
  end
end
