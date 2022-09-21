# frozen_string_literal: true

class Proficiency < ApplicationRecord
  belongs_to :club
  has_many :proficiency_signups
  has_many :users, through: :proficiency_signups
end
