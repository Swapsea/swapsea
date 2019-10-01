class AddIndexToClub < ActiveRecord::Migration[4.2]
  def change
  	add_index :clubs, :name
  end
end
