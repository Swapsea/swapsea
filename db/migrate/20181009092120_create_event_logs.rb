# frozen_string_literal: true

class CreateEventLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :event_logs do |t|
      t.string :subject
      t.string :desc

      t.timestamps
    end
  end
end
