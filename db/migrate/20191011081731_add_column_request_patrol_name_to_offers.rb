class AddColumnRequestPatrolNameToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :request_patrol_name, :string
  end
end
