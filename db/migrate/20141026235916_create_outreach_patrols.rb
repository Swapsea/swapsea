# frozen_string_literal: true

class CreateOutreachPatrols < ActiveRecord::Migration[5.0]
  def change
    create_table :outreach_patrols do |t|
      t.string :location
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
