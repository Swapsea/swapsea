# frozen_string_literal: true
class AddOrganisationToProficiencies < ActiveRecord::Migration
  def change
    add_column :proficiencies, :organisation, :string
  end
end
