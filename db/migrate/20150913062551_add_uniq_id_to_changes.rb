# frozen_string_literal: true

class AddUniqIdToChanges < ActiveRecord::Migration[5.0]
  def change
    add_column :swaps, :uniq_id, :string
  end
end
