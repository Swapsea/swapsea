# frozen_string_literal: true

class CreateProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.string :name
      t.datetime :start
      t.datetime :finish
      t.integer :max_signup
      t.integer :max_online_signup

      t.timestamps
    end
  end
end
