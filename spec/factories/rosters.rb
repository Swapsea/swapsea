# frozen_string_literal: true

FactoryBot.define do
  factory :roster do
    sequence(:start) { |n| n.days.from_now }
    finish { start + 3.hours }
    bbm { 1 }
    irbd { 2 }
    irbc { 2 }
    artc { 2 }
    spinal { 2 }
    firstaid { 2 }
    bronze { 2 }
    src { 2 }

    patrol
  end

  factory :past_roster, parent: :roster do
    sequence(:start) { |n| n.days.ago }
    finish { start + 3.hours }
  end
end
