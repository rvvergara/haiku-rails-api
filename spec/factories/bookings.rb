FactoryBot.define do
  factory :booking do
    confirmed { false }
    start_time { "2019-12-15 16:24:50" }
    patient_id { "" }
    practitioner_id { "" }
    consumed { false }
    expired { false }
    cancelled { false }
  end
end
