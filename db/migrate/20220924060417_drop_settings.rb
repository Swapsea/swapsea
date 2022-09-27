# frozen_string_literal: true

class DropSettings < ActiveRecord::Migration[6.0]
  def up
    drop_table :settings
  end
end
