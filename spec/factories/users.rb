# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :user do
    id { Faker::Number.number(digits: 8) }
    email { Faker::Internet.email }
    password { 'swapsea' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile_phone { Faker::PhoneNumber.cell_phone_with_country_code }

    club { Club.first || association(:club) }
  end

  factory :member_user, parent: :user, aliases: [:member] do
    after(:create) do |user, _evaluator|
      user.add_role :member
    end
  end

  factory :manager_user, parent: :user, aliases: [:manager] do
    after(:create) do |user, _evaluator|
      user.add_role :manager
    end
  end

  factory :admin_user, parent: :user, aliases: [:admin] do
    after(:create) do |user, _evaluator|
      user.add_role :admin
    end
  end
end
