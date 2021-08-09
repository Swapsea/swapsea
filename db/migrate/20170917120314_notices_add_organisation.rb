# frozen_string_literal: true
class NoticesAddOrganisation < ActiveRecord::Migration[5.0]
  def change
    add_column :notices, :organisation, :string
    remove_column :notices, :club_id, :string
  end
end
