class CreateOffers < ActiveRecord::Migration[4.2]
  def change
    create_table :offers do |t|
      t.integer :request_id
      t.integer :user_id
      t.string :comment
      t.string :mobile
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
