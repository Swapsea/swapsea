# frozen_string_literal: true

FactoryBot.define do
  factory :patrol do
    name { 'Patrol 2' }
    special_event { true }
    need_bbm { 1 }
    need_irbd { 1 }
    need_irbc { 1 }
    need_artc { 1 }
    need_firstaid { 0 }
    need_bronze { 3 }
    need_src { 0 }
    short_name { 'P02' }

    association :club, factory: :club
  end
end
