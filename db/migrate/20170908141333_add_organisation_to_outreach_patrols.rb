# frozen_string_literal: true

class AddOrganisationToOutreachPatrols < ActiveRecord::Migration[5.0]
  def change
    add_column :outreach_patrols, :organisation, :string
  end
end
