# frozen_string_literal: true
FactoryBot.define do
  factory :award do
    sequence(:award_number, 1000) { |n| n.to_s }
  end
end
