# frozen_string_literal: true
class AddSecretToRosters < ActiveRecord::Migration
  def change
    add_column :rosters, :secret, :string
  end
end
