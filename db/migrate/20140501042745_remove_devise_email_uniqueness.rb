class RemoveDeviseEmailUniqueness < ActiveRecord::Migration[4.2]
  def change
  	change_column :users, :email, :string, :unique => false
  end
end