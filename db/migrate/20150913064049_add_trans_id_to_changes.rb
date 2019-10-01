class AddTransIdToChanges < ActiveRecord::Migration[4.2]
  def change
    add_column :swaps, :trans_id, :string
  end
end
