require 'faker'
FactoryBot.define do
  factory :request do
    roster_id { 1 }
    user_id { 2 }
    comment { "MyString" }
    mobile { "MyString"}
    email { Faker::Internet.email}
    status { "MyString" }
  end
end
