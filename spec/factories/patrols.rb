# frozen_string_literal: true

FactoryBot.define do
  factory :patrol do
    sequence(:name) { |n| "Patrol #{n}" } # Unique for each patrol
    sequence(:short_name) { |n| "P#{n}" } # Unique for each patrol
    special_event { false }
    need_bbm { 1 }
    need_irbd { 1 }
    need_irbc { 1 }
    need_artc { 1 }
    need_firstaid { 0 }
    need_bronze { 3 }
    need_src { 0 }

    club { Club.first || association(:club) }

    factory :patrol_with_rosters do
      transient do
        rosters_count { 4 }
      end

      after(:create) do |patrol, evaluator|
        create_list(:roster, evaluator.rosters_count, patrol:)
      end
    end
  end
end
