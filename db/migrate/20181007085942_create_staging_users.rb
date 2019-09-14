class CreateStagingUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :staging_users do |t|

      t.integer :user_id
      t.string :email
      t.string :organisation
      t.string :last_name
      t.string :first_name
      t.string :preferred_name
      t.string :mobile_phone
      t.datetime :dob
      t.datetime :date_joined_organisation
      t.string :category
      t.string :status
      t.string :season

      t.timestamps
    end
  end
end
