# frozen_string_literal: true

class AddTransIdToChanges < ActiveRecord::Migration[5.0]
  def change
    add_column :swaps, :trans_id, :string
  end
end
