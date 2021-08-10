# frozen_string_literal: true

class RemoveDeviseEmailUniqueness < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, unique: false
  end
end
