# frozen_string_literal: true
class AddOrganisationToPatrols < ActiveRecord::Migration
  def change
  	add_column :patrols, :organisation, :string
  end
end
