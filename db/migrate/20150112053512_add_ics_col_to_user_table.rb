# frozen_string_literal: true

class AddIcsColToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ics, :string
  end
end
