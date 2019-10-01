class AddOrganisationToProficiencies < ActiveRecord::Migration[4.2]
  def change
  	add_column :proficiencies, :organisation, :string
  end
end
