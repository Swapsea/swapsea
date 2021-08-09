# frozen_string_literal: true

class AddColNeedSrcToPatrolTable < ActiveRecord::Migration
  def change
    add_column :patrols, :need_src, :integer
  end
end
