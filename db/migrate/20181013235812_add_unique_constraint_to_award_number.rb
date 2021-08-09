# frozen_string_literal: true
class AddUniqueConstraintToAwardNumber < ActiveRecord::Migration[5.0]
  def change
  	add_index :awards, :award_number, :unique => true
  end
end
