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

ActiveRecord::Schema[7.0].define(version: 2023_07_13_123859) do
  create_table "analogs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "tile_id"
    t.string "name"
    t.integer "font_size"
    t.string "font_color"
    t.integer "offset_x"
    t.integer "offset_y"
    t.string "align"
    t.integer "scale"
    t.integer "modbus_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_analogs_on_page_id"
  end

  create_table "digitals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "tile_id"
    t.string "name"
    t.integer "on"
    t.integer "off"
    t.integer "modbus_bit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_digitals_on_page_id"
  end

  create_table "gauges", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "tile_id"
    t.string "name"
    t.integer "width"
    t.integer "height"
    t.integer "min"
    t.integer "max"
    t.integer "offset_x"
    t.integer "offset_y"
    t.string "foreground_color"
    t.string "background_color"
    t.integer "modbus_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_gauges_on_page_id"
  end

  create_table "pages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "tile_id"
    t.integer "font_size"
    t.string "font_color"
    t.string "text"
    t.integer "offset_x"
    t.integer "offset_y"
    t.string "align"
    t.integer "scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.index ["page_id"], name: "index_titles_on_page_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "analogs", "pages"
  add_foreign_key "digitals", "pages"
  add_foreign_key "gauges", "pages"
  add_foreign_key "titles", "pages"
end
