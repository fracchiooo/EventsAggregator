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

ActiveRecord::Schema[7.0].define(version: 2022_10_10_170834) do
  create_table "comments", force: :cascade do |t|
    t.text "testo", null: false
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_id"
    t.string "organizer_id"
    t.string "coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "data_nascita", null: false
    t.string "immagine_profilo"
    t.string "username", default: "", null: false
    t.string "nome", default: "", null: false
    t.string "cognome", default: "", null: false
    t.integer "sesso", default: 0
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "events"
  add_foreign_key "comments", "events", on_delete: :cascade
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "like_comments", "comments"
  add_foreign_key "like_comments", "comments", on_delete: :cascade
  add_foreign_key "like_comments", "users"
  add_foreign_key "like_comments", "users", on_delete: :cascade
  add_foreign_key "segnala_cs", "comments"
  add_foreign_key "segnala_cs", "comments", on_delete: :cascade
  add_foreign_key "segnala_cs", "users"
  add_foreign_key "segnala_cs", "users", on_delete: :cascade
end
