class ChangeAwards < ActiveRecord::Migration[5.0]
  def change
    execute 'ALTER TABLE awards DROP CONSTRAINT award_number'
  end
end
