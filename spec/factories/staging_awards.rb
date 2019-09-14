FactoryBot.define do
  factory :staging_award do
    award_number { "MyString" }
    award_name { "MyString" }
    user_id { 1 }
    award_date { "2018-10-07 19:53:09" }
    proficiency_date { "2018-10-07 19:53:09" }
    expiry_date { "2018-10-07 19:53:09" }
    award_allocation_date { "2018-10-07 19:53:09" }
    proficiency_allocation_date { "2018-10-07 19:53:09" }
    originating_organisation { "MyString" }
  end
end
