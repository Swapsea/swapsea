class CreateStagingAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :staging_awards do |t|
      t.string :award_number
      t.string :award_name
      t.integer :user_id
      t.date :award_date
      t.date :proficiency_date
      t.date :expiry_date
      t.date :award_allocation_date
      t.date :proficiency_allocation_date
      t.string :originating_organisation
      t.timestamps
    end
  end
end
