class CreateEmails < ActiveRecord::Migration[4.2]
  def change
    create_table :emails do |t|

      t.timestamps
    end
  end
end
