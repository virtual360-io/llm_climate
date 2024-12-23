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

ActiveRecord::Schema[8.0].define(version: 2024_12_23_134329) do
  create_table "code_files", force: :cascade do |t|
    t.string "path"
    t.integer "overrall_grade"
    t.text "overral_review"
    t.integer "security_grade"
    t.text "security_review"
    t.integer "refactoring_grade"
    t.text "refactoring_review"
    t.integer "performance_grade"
    t.text "performance_review"
    t.integer "repository_id", null: false
    t.datetime "sync_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_code_files_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "code_files", "repositories"
end
