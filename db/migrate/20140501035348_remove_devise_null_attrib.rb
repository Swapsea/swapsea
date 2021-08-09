# frozen_string_literal: true
class RemoveDeviseNullAttrib < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :encrypted_password, :string, null: true
  end
end
