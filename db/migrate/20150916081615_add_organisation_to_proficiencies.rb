# frozen_string_literal: true

class AddOrganisationToProficiencies < ActiveRecord::Migration[5.0]
  def change
    add_column :proficiencies, :organisation, :string
  end
end
