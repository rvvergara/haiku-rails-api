json.id patient.id
json.first_name patient.first_name
json.last_name patient.last_name
json.nationality patient.nationality
json.address patient.address
json.postal_code patient.postal_code
json.birthday patient.birthday
json.passport patient.passport
json.contact_number patient.contact_number
json.points patient.points
json.profile_pic rails_blob_path(patient.profile_pic, only_path: true)
json.languages { json.array! patient.languages }
