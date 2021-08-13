# frozen_string_literal: true

class AddPhoneToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :phone, :string
  end
end
