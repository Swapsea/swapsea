# frozen_string_literal: true

class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :desc
      t.string :link
      t.string :link_desc
      t.string :image
      t.string :video
      t.integer :user_id
      t.integer :club_id
      t.boolean :system_wide
      t.datetime :visible_from
      t.datetime :visible_to
      t.boolean :visible

      t.timestamps
    end
  end
end
