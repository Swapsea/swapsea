# frozen_string_literal: true

class CreateProficiencySignups < ActiveRecord::Migration
  def change
    create_table :proficiency_signups do |t|
      t.integer :user_id
      t.integer :proficiency_id

      t.timestamps
    end
  end
end
