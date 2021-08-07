class ProficiencySignup < ActiveRecord::Base
	
	include PublicActivity::Common

	belongs_to :proficiency
	belongs_to :user

	# Returns User IDs for users that have signed up for a Proficiency.
	def self.signed 
		ProficiencySignup.pluck(:user_id)
	end

	# Returns User IDs for users that have NOT signed up for a Proficiency.
	# This class method is used to identify which users to email a friendly reminder for skills maintenance.
	def self.unsigned
		PatrolMember.pluck(:user_id) - ProficiencySignup.pluck(:user_id)
	end

end
