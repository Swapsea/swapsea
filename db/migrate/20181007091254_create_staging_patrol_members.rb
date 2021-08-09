# frozen_string_literal: true

class CreateStagingPatrolMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :staging_patrol_members do |t|
      t.integer :user_id
      t.string :default_position
      t.string :organisation
      t.string :patrol_name

      t.timestamps
    end
  end
end
