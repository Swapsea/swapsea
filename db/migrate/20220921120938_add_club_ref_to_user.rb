# frozen_string_literal: true

class AddClubRefToUser < ActiveRecord::Migration[6.0]
  def up
    add_reference :users, :club, foreign_key: true
    execute <<-SQL.squish
      UPDATE users u
      SET club_id = c.id
      FROM clubs c
      WHERE u.organisation = c.name;
    SQL
    remove_column :users, :organisation, :string
  end
end
