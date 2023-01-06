# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :offer do
    comment { Faker::Lorem.sentence(word_count: 3) }
    mobile { user ? user.mobile_phone : Faker::PhoneNumber.cell_phone_with_country_code }
    email { user ? user.email : Faker::Internet.email }
  end
end
