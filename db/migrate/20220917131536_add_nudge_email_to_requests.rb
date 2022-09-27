# frozen_string_literal: true

class AddNudgeEmailToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :nudge_email_opt_out, :bool, default: false
    add_column :requests, :nudge_email_opt_out_date, :timestamp
  end
end
