# frozen_string_literal: true

FactoryBot.define do
  factory :patrol_member do
    user { association(:user) }
    patrol { association(:patrol) }
  end
end
