class CreateLeads < ActiveRecord::Migration[4.2]
  def change
    create_table :leads, id: :serial, force: true do |t|
      t.string :name
      t.string :email
      t.string :organisation

      t.timestamps
    end
  end
end
