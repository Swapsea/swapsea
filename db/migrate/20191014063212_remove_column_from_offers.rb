class RemoveColumnFromOffers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :offers, :request_patrol_name
  end
end
