# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'swapsea' }
    club.name { 'Swapsea SLSC' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { 'male' }
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
