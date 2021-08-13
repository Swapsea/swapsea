# frozen_string_literal: true

class CreateNoticeAcknowledgements < ActiveRecord::Migration[5.0]
  def change
    create_table :notice_acknowledgements do |t|
      t.integer :user_id
      t.integer :notice_id

      t.timestamps
    end
  end
end
