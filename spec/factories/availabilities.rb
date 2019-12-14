# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    availability_date { '2019-12-14' }
    start_time { '2019-12-14 17:27:15' }
    end_time { '2019-12-14 17:27:15' }
    booked { false }
  end
end
