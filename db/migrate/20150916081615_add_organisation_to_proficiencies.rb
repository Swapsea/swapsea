class AddOrganisationToProficiencies < ActiveRecord::Migration
  def change
  	add_column :proficiencies, :organisation, :string
  end
end
