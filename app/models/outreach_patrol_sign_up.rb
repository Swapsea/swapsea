class OutreachPatrolSignUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :outreach_patrol
end
