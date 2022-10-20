# frozen_string_literal: true

class OldMigrations < ActiveRecord::Migration[5.2]
  REQUIRED_VERSION = 20_181_218_074_840
  def up
    raise StandardError, '`rails db:schema:load` must be run prior to `rails db:migrate`' if ActiveRecord::Migrator.current_version < REQUIRED_VERSION
  end
end
