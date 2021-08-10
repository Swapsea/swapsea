# frozen_string_literal: true

class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :short_name
      t.boolean :show_patrols
      t.boolean :show_rosters
      t.boolean :show_swaps
      t.boolean :show_outreach
      t.boolean :show_skills_maintenance
      t.timestamps
    end
  end
end
