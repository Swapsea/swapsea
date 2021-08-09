# frozen_string_literal: true

FactoryBot.define do
  factory :staging_patrol_member do
    user_id { 1 }
    patrol_name { 'MyString' }
    default_position { 'MyString' }
    organisation { 'MyString' }
  end
end
