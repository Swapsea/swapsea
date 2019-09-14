class NoticeAcknowledgement < ActiveRecord::Base


	belongs_to :notice 
	belongs_to :user

end
