# frozen_string_literal: true

FactoryBot.define do
  factory :club do
    name { 'Swapsea SLSC' }
    lat { '28.6141793' }
    lon { '77.2022662' }
    short_name { 'Swapsea' }
    show_patrols { true }
    show_rosters { true }
    show_swaps { true }
    show_skills_maintenance { true }
    show_outreach { false }
  end
end
