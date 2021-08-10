class AddOrganisationToPatrols < ActiveRecord::Migration
  def change
  	add_column :patrols, :organisation, :string
  end
end
