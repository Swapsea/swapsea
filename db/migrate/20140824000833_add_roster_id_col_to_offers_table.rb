# frozen_string_literal: true
class AddRosterIdColToOffersTable < ActiveRecord::Migration
  def change
    add_column :offers, :roster_id, :integer
  end
end
