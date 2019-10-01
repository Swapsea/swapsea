class AddRosterIdColToOffersTable < ActiveRecord::Migration[4.2]
  def change
  	add_column :offers, :roster_id, :integer 
  end
end
