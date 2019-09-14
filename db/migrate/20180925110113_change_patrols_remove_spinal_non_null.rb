class ChangePatrolsRemoveSpinalNonNull < ActiveRecord::Migration[5.0]
  def change
    change_column :patrols, :need_spinal, :integer, :null => true
  end
end
