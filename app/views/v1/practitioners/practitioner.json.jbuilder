# frozen_string_literal: true

json.practitioner do
  json.id practitioner.id
  json.user practitioner.user
  json.first_name practitioner.first_name
  json.last_name practitioner.last_name
  json.education do
    json.array! practitioner.education
  end
  json.specializations do
    json.array! practitioner.specializations
  end
  json.years_exp practitioner.years_exp
  json.biography practitioner.biography
  json.profile_pic rails_blob_path(practitioner.profile_pic, only_path: true)
end
