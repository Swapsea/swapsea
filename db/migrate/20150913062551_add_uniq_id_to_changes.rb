class AddUniqIdToChanges < ActiveRecord::Migration
  def change
    add_column :swaps, :uniq_id, :string
  end
end
