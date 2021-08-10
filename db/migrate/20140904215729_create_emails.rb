# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails, &:timestamps
  end
end
