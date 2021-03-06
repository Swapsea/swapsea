class CreatePatrols < ActiveRecord::Migration
  def change
    create_table :patrols do |t|
      t.string :name
      t.string :key
      t.boolean :special_event
      t.integer :need_bbm
      t.integer :need_irbd
      t.integer :need_irbc
      t.integer :need_artc
      t.integer :need_firstaid
      t.integer :need_spinal
      t.integer :need_bronze

      t.timestamps
    end
  end
end
