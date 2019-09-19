FactoryBot.define do
  factory :patrol do
    name { "MyString" }
    special_event { true }
    need_bbm { 1 }
    need_irbd { 1 }
    need_irbc { 1 }
    need_artc { 1 }
    need_firstaid { 0 }
    need_bronze { 3 }
    need_src { 0 }
    organisation { "Swapsea SLSC" }
    short_name { "P02" }
  end
end
