# frozen_string_literal: true

class AddIndexToClub < ActiveRecord::Migration
  def change
    add_index :clubs, :name
  end
end
