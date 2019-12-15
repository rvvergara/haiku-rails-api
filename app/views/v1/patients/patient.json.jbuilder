# frozen_string_literal: true

json.patient do
  json.partial! 'v1/shared/patient', patient: patient
  json.user do
    json.partial! 'v1/shared/user', user: patient.user
  end
end
