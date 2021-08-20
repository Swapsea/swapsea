# frozen_string_literal: true

class AddIndexToClub < ActiveRecord::Migration[5.0]
  def change
    add_index :clubs, :name
  end
end
