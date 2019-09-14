class SkillsMaintenanceNotNull < ActiveRecord::Migration[5.0]
  def change    
    change_column_null(:proficiencies, :organisation, false)
    # change_column(:users, :admin, :string, :default => "")
  end
end
