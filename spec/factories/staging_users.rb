FactoryBot.define do
  factory :staging_user do
    email { 'MyString' }
    organisation { 'MyString' }
    last_name { 'MyString' }
    first_name { 'MyString' }
    preferred_name { 'MyString' }
    mobile_phone { 'MyString' }
    dob { '2018-10-07 19:59:42' }
    date_joined_organisation { '2018-10-07 19:59:42' }
    category { 'MyString' }
    status { 'MyString' }
    season { 'MyString' }
  end
end
