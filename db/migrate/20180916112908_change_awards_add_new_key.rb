class ChangeAwardsAddNewKey < ActiveRecord::Migration[5.0]
  def change

    execute "ALTER TABLE awards DROP CONSTRAINT awards_pkey;"

    add_column :awards, :id, :primary_key, before: :award_number

  end
end
