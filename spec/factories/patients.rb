FactoryBot.define do
  factory :patient do
    first_name { "MyString" }
    last_name { "MyString" }
    nationality { "MyString" }
    address { "MyText" }
    postal_code { "MyString" }
    birthday { "2019-12-13" }
    languages { "MyString" }
    passport { "MyString" }
    contact_number { "MyString" }
    points { "" }
  end
end
