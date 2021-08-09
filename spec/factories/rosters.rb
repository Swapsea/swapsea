# frozen_string_literal: true
FactoryBot.define do
  factory :roster do
    organisation { 'MyString' }
    patrol_name { 'MyString' }
    start { '2018-10-07 19:53:09' }
    finish { '2018-10-07 19:53:09' }
    bbm { 1 }
    irbd { 2 }
    irbc { 2 }
    artc { 2 }
    spinal { 2 }
    firstaid { 2 }
    bronze { 2 }
    src { 2 }
  end
end
