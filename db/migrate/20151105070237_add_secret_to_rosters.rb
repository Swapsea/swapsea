class AddSecretToRosters < ActiveRecord::Migration[4.2]
  def change
    add_column :rosters, :secret, :string
  end
end
