# frozen_string_literal: true

class AddSecretToRosters < ActiveRecord::Migration[5.0]
  def change
    add_column :rosters, :secret, :string
  end
end
