# frozen_string_literal: true

class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :awards, :user_id
    add_index :awards, :award_name
    add_index :patrols, :key
    add_index :patrol_members, :patrol_key
    add_index :patrol_members, :user_id
    add_index :swaps, :roster_id
    add_index :swaps, :user_id
    add_index :offers, :request_id
    add_index :offers, :user_id
    add_index :requests, :roster_id
    add_index :requests, :user_id
    add_index :rosters, :patrol_key
    add_index :users, :id
  end
end
