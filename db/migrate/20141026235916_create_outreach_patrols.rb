class CreateOutreachPatrols < ActiveRecord::Migration
  def change
    create_table :outreach_patrols do |t|
      t.string :location
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
