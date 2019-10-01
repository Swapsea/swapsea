class AddUniqIdToChanges < ActiveRecord::Migration[4.2]
  def change
    add_column :swaps, :uniq_id, :string
  end
end
