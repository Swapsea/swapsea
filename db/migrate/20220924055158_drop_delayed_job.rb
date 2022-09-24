# frozen_string_literal: true

class DropDelayedJob < ActiveRecord::Migration[6.0]
  def up
    drop_table :delayed_jobs
  end
end
