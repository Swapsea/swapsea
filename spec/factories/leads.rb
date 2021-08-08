require 'faker'
FactoryBot.define do
  factory :lead do
    name { 'MyString' }
    email { Faker::Internet.email}
    organisation { 'MyString' }
    phone { 'MyString' }
  end
end
