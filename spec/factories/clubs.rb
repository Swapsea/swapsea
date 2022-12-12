# frozen_string_literal: true

FactoryBot.define do
  factory :club do
    sequence(:name) { |n| "Club#{n} SLSC" } # Unique for each club
    sequence(:short_name) { |n| "Club#{n}" } # Unique for each club
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

    factory :club_with_patrols do
      transient do
        patrols_count { 3 }
      end

      after(:create) do |club, evaluator|
        create_list(:patrol_with_rosters, evaluator.patrols_count, club:)
      end
    end
  end
end
