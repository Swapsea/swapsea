# frozen_string_literal: true

class AddRosterIdColToOffersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :roster_id, :integer
  end
end
