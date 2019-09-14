class AddIcsColToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :ics, :string
  end
end
