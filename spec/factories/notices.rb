FactoryBot.define do
  factory :notice do
    title { "MyString" }
    desc { "MyString" }
    link_desc { "MyString" }
    user_id { 1 }
    system_wide {true}
    visible_from { "2018-10-07 19:53:09" }
    visible_to { "2018-10-07 19:53:09" }
    visible { true }
    organisation { "MyString" }
    image { "MyString" }
    video { "MyString" }
  end
end