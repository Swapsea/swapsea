# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :request do
    mobile { user ? user.mobile_phone : Faker::PhoneNumber.cell_phone_with_country_code }
    email { user ? user.email : Faker::Internet.email }
    comment { Faker::Lorem.sentence(word_count: 5) }
  end
end
