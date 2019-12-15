# frozen_string_literal: true

json.user do
  json.partial! 'v1/shared/user', user: user
  json.profile do
    if user.profile do
      json.partial! 'v1/shared/practitioner', practitioner: user.profile.profilable if user.role == 'practitioner'
      json.partial! 'v1/shared/patient', patient: user.profile.profilable if user.role == 'patient'
    end
  end
end
