# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :request do
    comment { 'MyString' }
    mobile { 'MyString' }
    email { Faker::Internet.email }
    status { 'open' }

    association :user
    association :roster
  end
end
