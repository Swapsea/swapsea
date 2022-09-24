# frozen_string_literal: true

FactoryBot.define do
  factory :patrol_member do
    user_id { 1 }
    default_position { 'Bronzie' }
    # patrol.club.name { 'Swapsea SLSC' }
    patrol.name { 'Patrol 1' }
  end
end
