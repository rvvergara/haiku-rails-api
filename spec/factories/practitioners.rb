# frozen_string_literal: true

FactoryBot.define do
  factory :practitioner do
    first_name { 'MyString' }
    last_name { 'MyString' }
    address { 'MyString' }
    biography { 'MyText' }
    years_exp { 'MyString' }
  end
end
