# frozen_string_literal: true

FactoryBot.define do
  factory :club do
    name { 'Swapsea SLSC' }
    short_name { 'Swapsea' }
    lat { '28.6141793' }
    lon { '77.2022662' }
    is_active { true }
    show_patrols { true }
    show_rosters { true }
    show_swaps { true }
    show_skills_maintenance { true }
    show_outreach { false }
    enable_reminders_email { true }
    enable_reminders_sms { false }
  end
end
