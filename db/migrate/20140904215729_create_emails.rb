# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails, &:timestamps
  end
end
