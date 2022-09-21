class AddClubRefToProficiency < ActiveRecord::Migration[6.0]
  def change
    add_reference :proficiencies, :club, foreign_key: true
    execute <<-SQL
      UPDATE proficiencies p
      SET club_id = c.id
      FROM clubs c
      WHERE p.organisation = c.name;
    SQL
    remove_column :proficiencies, :organisation, :string
  end
end
