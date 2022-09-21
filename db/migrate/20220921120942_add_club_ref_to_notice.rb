class AddClubRefToNotice < ActiveRecord::Migration[6.0]
  def change
    add_reference :notices, :club, foreign_key: true
    execute <<-SQL
      UPDATE notices n
      SET club_id = c.id
      FROM clubs c
      WHERE n.organisation = c.name;
    SQL
    remove_column :notices, :organisation, :string
  end
end
