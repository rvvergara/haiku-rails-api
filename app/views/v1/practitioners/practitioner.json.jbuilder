# frozen_string_literal: true

json.practitioner do
  json.partial! 'v1/shared/practitioner', practitioner: practitioner
  json.user do
    json.partial! 'v1/shared/user', user: practitioner.user
  end
end
