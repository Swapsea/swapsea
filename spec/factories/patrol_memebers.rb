# frozen_string_literal: true

FactoryBot.define do
  factory :patrol_member do
    user_id { 1 }
    default_position { 'MyString' }
    organisation { 'MyString' }
    patrol_name { 'MyString' }
  end
end
