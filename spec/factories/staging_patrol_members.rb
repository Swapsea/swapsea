FactoryBot.define do
  factory :staging_patrol_member do
    user_id { 1 }
    patrol_id { 1 }
    patrol_key { "MyString" }
    default_position { "MyString" }
    organisation { "MyString" }
  end
end
