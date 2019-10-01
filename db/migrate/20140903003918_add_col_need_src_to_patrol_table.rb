class AddColNeedSrcToPatrolTable < ActiveRecord::Migration[4.2]
  def change
  	add_column :patrols, :need_src, :integer 
  end
end
