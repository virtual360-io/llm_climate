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

ActiveRecord::Schema[8.0].define(version: 2024_12_30_145526) do
  create_table "code_files", force: :cascade do |t|
    t.text "content"
    t.string "path"
    t.decimal "overall_grade"
    t.text "overall_review"
    t.decimal "security_grade"
    t.text "security_review"
    t.decimal "refactoring_grade"
    t.text "refactoring_review"
    t.decimal "performance_grade"
    t.text "performance_review"
    t.integer "repository_id", null: false
    t.datetime "sync_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path"], name: "index_code_files_on_path"
    t.index ["repository_id"], name: "index_code_files_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "code_files", "repositories"
  add_foreign_key "sessions", "users"
end
