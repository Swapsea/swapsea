class NewUserFields < ActiveRecord::Migration
  def change

  	#add_column :users, :state,	:string
  	#add_column :users, :branch,	:string
  	add_column :users, :organisation,	:string
  	add_column :users, :last_name,	:string
  	#add_column :users, :middle_name,	:string
  	add_column :users, :first_name,	:string
  	add_column :users, :preferred_name,	:string
  	#add_column :users, :home_suburb,	:string
  	#add_column :users, :home_state,	:string
  	#add_column :users, :home_phone,	:string
  	add_column :users, :mobile_phone,	:string
  	#add_column :users, :alternate_phone,	:string
  	#add_column :users, :preferred_contact_no,	:string
  	add_column :users, :dob,	:date
  	add_column :users, :date_joined_organisation,	:date
  	#add_column :users, :occupation,	:string
  	#add_column :users, :drivers_license_number,	:string
  	#add_column :users, :drivers_license_type,	:string
  	#add_column :users, :drivers_license_expiry,	:string
  	#add_column :users, :marine_license_number,	:string
  	#add_column :users, :marine_license_expiry,	:string
  	#add_column :users, :do_not_send_communications,	:string
  	add_column :users, :category,	:string
  	#add_column :users, :blood_type,	:string
  	#add_column :users, :emergency_last_name,	:string
  	#add_column :users, :emergency_first_name,	:string
  	#add_column :users, :emergency_suburb,	:string
  	#add_column :users, :emergency_state,	:string
  	#add_column :users, :emergency_home_phone,	:string
  	#add_column :users, :emergency_business_phone,	:string
  	#add_column :users, :emergency_mobile_phone,	:string
  	#add_column :users, :emergency_alternate_phone,	:string
  	#add_column :users, :emergency_contact_relationship,	:string
    add_column :users, :status, :string
    add_column :users, :season, :string
    add_column :users, :gender, :string
    add_column :users, :account, :boolean

  end
end
