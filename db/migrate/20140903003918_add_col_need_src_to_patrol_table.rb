# frozen_string_literal: true

class AddColNeedSrcToPatrolTable < ActiveRecord::Migration[5.0]
  def change
    add_column :patrols, :need_src, :integer
  end
end
