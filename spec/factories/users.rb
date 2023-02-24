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
    date_joined_organisation { DateTime.now }
    status { 'Active' }

    club { Club.first || association(:club) }
    patrol { association(:patrol) }

    transient do
      position { '' } # Default blank
    end
    after(:create) do |user, _evaluator|
      user.default_position = _evaluator.position
      user.patrol_member&.default_position = _evaluator.position
      user.patrol_member&.save!
    end
  end

  factory :member_user, parent: :user, aliases: [:member] do
    after(:create) do |user, _evaluator|
      user.add_role :member
    end
  end

  factory :manager_user, parent: :member_user, aliases: [:manager] do
    after(:create) do |user, _evaluator|
      user.add_role :manager
    end
  end

  factory :admin_user, parent: :member_user, aliases: [:admin] do
    after(:create) do |user, _evaluator|
      user.add_role :admin
    end
  end
end
