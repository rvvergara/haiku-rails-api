# frozen_string_literal: true

FactoryBot.define do
  factory :clinic do
    avatar { 'MyString' }
    name { 'MyString' }
    address { 'MyString' }
    postal_code { 'MyString' }
    category { 'MyString' }
    openning_hours { 'MyString' }
    practitioner_id { '' }
  end
end
