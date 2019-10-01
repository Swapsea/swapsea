class AddFieldsToEmail < ActiveRecord::Migration[4.2]
  def change
  	add_column :emails, :to, :string
  	add_column :emails, :cc, :string
  	add_column :emails, :bcc, :string
  	add_column :emails, :subject, :string
  end
end
