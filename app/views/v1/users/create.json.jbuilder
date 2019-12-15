# frozen_string_literal: true

json.user do
  json.partial! 'v1/shared/user', user: user
  json.profile do
    json.partial! 'v1/shared/practitioner', practitioner: user.profile.profilable if user.role == 'practitioner'
  end
end
json.token token
