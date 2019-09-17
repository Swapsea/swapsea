require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "swapsea" }
    organisation { "Swapsea SLSC" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    patrol_name { Faker::Name.name }
    gender { "male" }
  end

  factory :member_user, parent: :user, aliases: [ :member ] do
    after(:create) do |user, evaluator|
      user.add_role :member
    end
  end

  factory :admin_user, parent: :user, aliases: [ :administrator ] do
    after(:create) do |user, evaluator|
      user.add_role :admin
    end
  end
end
