class AddPhoneToLeads < ActiveRecord::Migration[4.2]
  def change
    add_column :leads, :phone, :string
  end
end
