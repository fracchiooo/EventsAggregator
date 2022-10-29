# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_29_113906) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "testo", null: false
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "drive_photos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.string "drive_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drive_url"], name: "index_drive_photos_on_drive_url", unique: true
    t.index ["event_id"], name: "index_drive_photos_on_event_id"
    t.index ["user_id", "event_id"], name: "index_drive_photos_on_user_id_and_event_id"
    t.index ["user_id"], name: "index_drive_photos_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_id"
    t.string "organizer_id"
    t.string "coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_favorites_on_event_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "like_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_like_comments_on_comment_id"
    t.index ["user_id", "comment_id"], name: "index_like_comments_on_user_id_and_comment_id", unique: true
    t.index ["user_id"], name: "index_like_comments_on_user_id"
  end

  create_table "like_events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.string "promoter"
    t.boolean "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_like_events_on_event_id"
    t.index ["user_id", "event_id"], name: "index_like_events_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_like_events_on_user_id"
  end

  create_table "partecipants", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "organizer_id"
    t.index ["event_id"], name: "index_partecipants_on_event_id"
    t.index ["user_id"], name: "index_partecipants_on_user_id"
  end

  create_table "segnala_cs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_segnala_cs_on_comment_id"
    t.index ["user_id", "comment_id"], name: "index_segnala_cs_on_user_id_and_comment_id", unique: true
    t.index ["user_id"], name: "index_segnala_cs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "data_nascita"
    t.string "immagine_profilo"
    t.string "username", null: false
    t.string "nome", null: false
    t.string "cognome", null: false
    t.integer "sesso", default: 0
    t.boolean "account_active", default: true
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "events", on_delete: :cascade
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "drive_photos", "events", on_delete: :cascade
  add_foreign_key "drive_photos", "users", on_delete: :cascade
  add_foreign_key "favorites", "events"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "users", on_delete: :cascade
  add_foreign_key "like_comments", "comments"
  add_foreign_key "like_comments", "comments", on_delete: :cascade
  add_foreign_key "like_comments", "users"
  add_foreign_key "like_comments", "users", on_delete: :cascade
  add_foreign_key "like_events", "events"
  add_foreign_key "like_events", "users"
  add_foreign_key "like_events", "users", on_delete: :cascade
  add_foreign_key "partecipants", "events"
  add_foreign_key "partecipants", "users"
  add_foreign_key "partecipants", "users", on_delete: :cascade
  add_foreign_key "segnala_cs", "comments"
  add_foreign_key "segnala_cs", "comments", on_delete: :cascade
  add_foreign_key "segnala_cs", "users"
  add_foreign_key "segnala_cs", "users", on_delete: :cascade
end
