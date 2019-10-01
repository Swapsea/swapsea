class AddIcsColToUserTable < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :ics, :string
  end
end
