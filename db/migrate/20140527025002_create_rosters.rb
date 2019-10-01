class CreateRosters < ActiveRecord::Migration[4.2]
  def change
    create_table :rosters do |t|
      t.string :organisation
      t.string :patrol
      t.string :key
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
