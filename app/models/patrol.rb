# frozen_string_literal: true

class Patrol < ApplicationRecord
  belongs_to :club
  has_many :patrol_members
  has_many :users, through: :patrol_members
  has_many :rosters
  has_many :awards, through: :users

  # Returns array of patrol requirements
  def requirements
    {
      bbm: need_bbm,
      irbd: need_irbd,
      irbc: need_irbc,
      artc: need_artc,
      bronze: need_bronze,
      src: need_src
    }
  end

  # AC to refactor method based on user award flags on User model.
  def qualifications
    bronze = awards.where(award_name: 'Bronze Medallion').count
    bbm = awards.where(award_name: 'Silver Medallion Beach Management').count
    artc = awards.where({ award_name: 'Advanced Resuscitation Techniques Certificate' } || { award_name: 'Advanced Resuscitation Techniques [AID]' } || { award_name: 'Advanced Resuscitation Techniques Refresher' } || { award_name: 'Advanced Resuscitation Certificate' } || { award_name: 'Advanced Resuscitation Certificate Instructor' }).count
    irbc = awards.where(award_name: 'IRB Crew Certificate').count
    irbd = awards.where(award_name: 'Silver Medallion IRB Driver').count
    src = awards.where({ award_name: 'Surf Rescue Certificate' } || { award_name: 'Surf Rescue Certificate (CPR Endorsed)' }).count
    {
      bbm:,
      irbd:,
      irbc:,
      artc:,
      bronze:,
      src:
    }
  end

  # Returns array of users who have default position of 'Patrol Captain'.
  def patrol_captains
    users.where(default_position: 'Patrol Captain')
  end

  # Returns array of users who have default position of 'Vice Captain'.
  def vice_captains
    users.where(default_position: 'Vice Captain')
  end

  def short_name
    self[:short_name] || name
  end
end
