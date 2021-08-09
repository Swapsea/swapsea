# frozen_string_literal: true

class OutreachPatrolSignUp < ApplicationRecord
  belongs_to :user
  belongs_to :outreach_patrol
end
