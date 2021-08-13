# frozen_string_literal: true

class CreateSwaps < ActiveRecord::Migration[5.0]
  def change
    create_table :swaps do |t|
      t.string :roster_id
      t.string :user_id
      t.boolean :on_off_patrol

      t.timestamps
    end
  end
end
