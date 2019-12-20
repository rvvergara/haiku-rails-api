# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :practitioner do
      role { 'practitioner' }
      email { Faker::Internet.email(name: 'Doctor', domain: 'igaku.co') }
    end

    trait :patient do
      role { 'patient' }
      email { Faker::Internet.email(name: 'Donald', domain: 'gmail.com') }
    end

    trait :invalid_user do
      email { Faker::Internet.email }
    end

    password { 'password' }
  end
end
