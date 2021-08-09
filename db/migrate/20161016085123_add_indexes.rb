# frozen_string_literal: true

class AddIndexes < ActiveRecord::Migration
  def change
    add_index :patrols, %i[organisation name]
    add_index :patrol_members, [:organisation]
    add_index :rosters, %i[organisation patrol_name]
    execute('ALTER TABLE public.awards ADD CONSTRAINT award_number UNIQUE (award_number);')
  end
end
