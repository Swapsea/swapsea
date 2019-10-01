class CreatePatrolMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :patrol_members do |t|
      t.integer :user_id
      t.integer :patrol_id
      t.string :patrol_key
      t.string :default_position
      t.string :organisation

      t.timestamps
    end
  end
end
