# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :offer do
    comment { 'MyString' }
    mobile { 'MyString' }
    email { Faker::Internet.email }

    association :request
    association :user

    future_dated_roster # Default future dated

    trait :future_dated_roster do
      association :roster, start: 7.days.from_now, finish: 8.days.from_now
    end

    trait :past_dated_roster do
      association :roster, start: 8.days.ago, finish: 7.days.ago
    end
  end
end
