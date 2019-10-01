class CreateOutreachPatrolSignUps < ActiveRecord::Migration[4.2]
  def change
    create_table :outreach_patrol_sign_ups do |t|
      t.references :user, index: true
      t.references :outreach_patrol, index: true

      t.timestamps
    end
  end
end
