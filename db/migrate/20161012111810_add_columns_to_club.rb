class AddColumnsToClub < ActiveRecord::Migration[4.2]
  def change
  	add_column :clubs, :lat, :float, default: 0, null: false		# Latitude for weather widget
  	add_column :clubs, :lon, :float, default: 0, null: false		# Longitude for weather widget
  end
end
