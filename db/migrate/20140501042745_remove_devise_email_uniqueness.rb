# frozen_string_literal: true

class RemoveDeviseEmailUniqueness < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, unique: false
  end
end
