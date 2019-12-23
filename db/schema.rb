# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_23_081310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "availabilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "practitioner_id", null: false
    t.date "availability_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.boolean "booked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "booking_id"
    t.index ["booking_id"], name: "index_availabilities_on_booking_id"
    t.index ["practitioner_id"], name: "index_availabilities_on_practitioner_id"
  end

  create_table "bookings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "status", default: "new", null: false
    t.date "appointment_date", null: false
    t.time "start_time", null: false
    t.uuid "patient_id", null: false
    t.uuid "practitioner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "patient_remarks"
    t.text "practitioner_remarks"
    t.index ["patient_id"], name: "index_bookings_on_patient_id"
    t.index ["practitioner_id"], name: "index_bookings_on_practitioner_id"
  end

  create_table "clinics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "avatar"
    t.string "name", null: false
    t.string "address", null: false
    t.string "postal_code", default: "", null: false
    t.string "category", default: "", null: false
    t.string "openning_hours", default: [], array: true
    t.uuid "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_clinics_on_creator_id"
    t.index ["name"], name: "index_clinics_on_name"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "nationality"
    t.text "address"
    t.string "postal_code"
    t.date "birthday"
    t.string "languages", default: [], array: true
    t.string "passport"
    t.string "contact_number"
    t.bigint "points", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_pic"
  end

  create_table "practitioners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "biography", default: "", null: false
    t.string "years_exp", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "education", default: [], array: true
    t.string "specializations", default: [], array: true
    t.string "profile_pic"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "profilable_id", null: false
    t.string "profilable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profilable_id"], name: "index_profiles_on_profilable_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "availabilities", "practitioners"
  add_foreign_key "bookings", "patients"
  add_foreign_key "bookings", "practitioners"
  add_foreign_key "profiles", "users"
end
