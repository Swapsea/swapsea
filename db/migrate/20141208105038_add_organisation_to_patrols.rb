# frozen_string_literal: true

class AddOrganisationToPatrols < ActiveRecord::Migration[5.0]
  def change
    add_column :patrols, :organisation, :string
  end
end
