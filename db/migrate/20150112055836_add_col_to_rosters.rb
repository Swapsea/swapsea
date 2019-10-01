class AddColToRosters < ActiveRecord::Migration[4.2]
  def change
    add_column :rosters, :bbm, :integer
    add_column :rosters, :irbd, :integer
    add_column :rosters, :irbc, :integer
    add_column :rosters, :artc, :integer
    add_column :rosters, :spinal, :integer
    add_column :rosters, :firstaid, :integer
    add_column :rosters, :bronze, :integer
    add_column :rosters, :src, :integer
  end
end
