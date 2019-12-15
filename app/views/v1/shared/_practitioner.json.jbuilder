json.id practitioner.id
json.first_name practitioner.first_name
json.last_name practitioner.last_name
json.biography practitioner.biography
json.years_exp practitioner.years_exp
json.profile_pic rails_blob_path(practitioner.profile_pic, only_path: true)
json.education { json.array! practitioner.education }
json.specializations { json.array! practitioner.specializations }