# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bbm, :boolean
    add_column :users, :irbd, :boolean
    add_column :users, :irbc, :boolean
    add_column :users, :artc, :boolean
    add_column :users, :spinal, :boolean
    add_column :users, :firstaid, :boolean
    add_column :users, :bronze, :boolean
    add_column :users, :src, :boolean
  end
end
