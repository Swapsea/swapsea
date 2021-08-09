# frozen_string_literal: true
json.array!(@awards) do |award|
  json.extract! award, :id, :user_id, :award_name, :award_number, :award_date, :proficiency_date, :expiry_date, :award_allocation_date, :proficiency_allocation_date, :originating_organisation
  json.url award_url(award, format: :json)
end
