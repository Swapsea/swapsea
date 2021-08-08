require 'faker'
FactoryBot.define do
  factory :email do
    to { Faker::Internet.email }
    cc { Faker::Internet.email }
    bcc { Faker::Internet.email }
    subject { 'MyString' }
  end
end
