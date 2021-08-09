# frozen_string_literal: true
class ChangeStagingUserTable < ActiveRecord::Migration[5.0]
  def change
    change_column :staging_users, :dob, :date
    change_column :staging_users, :date_joined_organisation, :date
  end
end
