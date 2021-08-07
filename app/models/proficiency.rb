class Proficiency < ActiveRecord::Base
	
	belongs_to :club, foreign_key: :organisation, primary_key: :name
	has_many :proficiency_signups
	has_many :users, :through => :proficiency_signups

end
