# frozen_string_literal: true

class AddIcsColToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :ics, :string
  end
end
