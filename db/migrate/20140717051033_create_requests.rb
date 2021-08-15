# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :roster_id
      t.integer :user_id
      t.string :comment
      t.string :mobile
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
