# frozen_string_literal: true
class AddSmsableToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :smsable, :boolean, default: false
  end
end
