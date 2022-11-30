# frozen_string_literal: true

FactoryBot.define do
  factory :roster do
    start { 7.days.from_now }
    finish { 8.days.from_now }
    bbm { 1 }
    irbd { 2 }
    irbc { 2 }
    artc { 2 }
    spinal { 2 }
    firstaid { 2 }
    bronze { 2 }
    src { 2 }

    association :patrol
  end
end
