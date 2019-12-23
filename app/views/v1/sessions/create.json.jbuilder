# frozen_string_literal: true

json.user do
  json.partial! 'v1/shared/user', user: user
  if user.profile
    json.profile do
      json.partial! 'v1/shared/practitioner', practitioner: user.profilable if user.role == 'practitioner'

      json.partial! 'v1/shared/patient', patient: user.profilable if user.role == 'patient'
    end
  end
end
json.token token
