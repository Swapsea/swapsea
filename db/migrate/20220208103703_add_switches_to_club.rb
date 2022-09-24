# frozen_string_literal: true

class AddSwitchesToClub < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :is_active, :bool, default: false
    add_column :clubs, :enable_reminders_email, :bool, default: true
    add_column :clubs, :enable_reminders_sms, :bool, default: false
  end
end
