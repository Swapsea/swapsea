FactoryBot.define do
  factory :club do
    name { Faker::Name.name }
    lat { Faker::Address.latitude.lat }
    lon { Faker::Address.longitude.lon }
    # short_name { Faker::Name.short_name }
    # show_patrols { Faker::Boolean.boolean }
  end
end