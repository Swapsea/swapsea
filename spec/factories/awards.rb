# frozen_string_literal: true

FactoryBot.define do
  factory :award do
    award_number { Faker::Number.number(digits: 8) }
  end
end
