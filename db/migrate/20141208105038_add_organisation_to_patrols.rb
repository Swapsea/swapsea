class AddOrganisationToPatrols < ActiveRecord::Migration[4.2]
  def change
  	add_column :patrols, :organisation, :string 
  end
end
