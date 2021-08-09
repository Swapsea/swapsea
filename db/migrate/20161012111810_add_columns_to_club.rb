# frozen_string_literal: true

class AddColumnsToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :lat, :float, default: 0, null: false		# Latitude for weather widget
    add_column :clubs, :lon, :float, default: 0, null: false		# Longitude for weather widget
  end
end
