FactoryBot.define do
  factory :user do
  end

  factory :member_user, parent: :user, aliases: [ :member ] do
    after(:create) do |user, evaluator|
      user.add_role :member
    end
  end

  factory :admin_user, parent: :user, aliases: [ :administrator ] do
    after(:create) do |user, evaluator|
      user.add_role :admin
    end
  end
end
