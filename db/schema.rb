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

ActiveRecord::Schema[7.1].define(version: 2024_09_16_074957) do
  create_table "online_files", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.integer "pages"
    t.integer "processed_pages"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "row_number"
    t.datetime "date_time"
    t.integer "amount"
    t.string "content"
    t.string "status"
    t.integer "page_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "online_file_id", null: false
    t.index ["online_file_id"], name: "index_transactions_on_online_file_id"
  end

  add_foreign_key "transactions", "online_files"
end
