# frozen_string_literal: true

json.user do
  json.id user.id
  json.email user.email
  json.role user.role
end
json.token token
