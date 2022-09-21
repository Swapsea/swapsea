class RemovePatrolNameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :patrol_name, :string
  end
end
