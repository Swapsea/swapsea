class AwardsPrimaryKeyAdd < ActiveRecord::Migration[5.0]
  def change
    #remove_index :awards, :award_number

    # Added line to remove primary key from ID as two primary keys cannot exist.
    # ActiveRecord::StatementInvalid: PG::InvalidTableDefinition: ERROR:  multiple primary keys for table "awards" are not allowed
    # execute "ALTER TABLE awards DROP CONSTRAINT awards_pkey"

    execute "ALTER TABLE awards ADD PRIMARY KEY (award_number);"
  end
end
