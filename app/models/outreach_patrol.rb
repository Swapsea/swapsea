# frozen_string_literal: true

class OutreachPatrol < ActiveRecord::Base
  belongs_to :club, foreign_key: :organisation, primary_key: :name
  has_many :outreach_patrol_sign_ups
  has_many :users, through: :outreach_patrol_sign_ups
end
