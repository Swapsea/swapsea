class CreateNoticeAcknowledgements < ActiveRecord::Migration[4.2]
  def change
    create_table :notice_acknowledgements do |t|
      t.integer :user_id
      t.integer :notice_id

      t.timestamps
    end
  end
end
