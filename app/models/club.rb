# frozen_string_literal: true
class Club < ActiveRecord::Base
	has_many :patrols, -> { order('id ASC') }, foreign_key: 'organisation', primary_key: 'name'
	has_many :patrol_members, :through => :patrols
	has_many :rosters, :through => :patrols
	has_many :requests, :through => :rosters
	has_many :users, :through => :patrol_members
	has_many :awards, :through => :users
	has_many :proficiencies
	has_many :outreach_patrols
	has_many :notices

	scope :show_patrols, -> { where(show_patrols: true) }
end
