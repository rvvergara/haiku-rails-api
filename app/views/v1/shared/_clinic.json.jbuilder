# frozen_string_literal: true

json.id clinic.id
json.creator_id clinic.creator_id
json.name clinic.name
json.address clinic.address
json.avatar rails_blob_path(clinic.avatar, only_path: true)
json.postal_code clinic.postal_code
json.category clinic.category
json.operating_hours { json.array! clinic.operating_hours }
