class AddSwitchesToClub < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :is_active, :bool
    add_column :clubs, :enable_patrol_reminders_email, :bool
    add_column :clubs, :enable_patrol_reminders_sms, :bool
    add_column :clubs, :enable_proficiency_reminders_email, :bool
  end
end
