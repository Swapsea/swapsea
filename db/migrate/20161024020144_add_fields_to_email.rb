class AddFieldsToEmail < ActiveRecord::Migration
  def change
  	add_column :emails, :to, :string
  	add_column :emails, :cc, :string
  	add_column :emails, :bcc, :string
  	add_column :emails, :subject, :string
  end
end
