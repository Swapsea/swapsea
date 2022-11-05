# frozen_string_literal: true

class AddDeclineRemarkToOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :decline_remark, :string
  end
end
