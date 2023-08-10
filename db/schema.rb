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

ActiveRecord::Schema[7.0].define(version: 2023_08_07_215315) do
  create_table "analog_values", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "value1", precision: 10, scale: 1
    t.decimal "value2", precision: 10, scale: 1
    t.decimal "value3", precision: 10, scale: 1
    t.decimal "value4", precision: 10, scale: 1
    t.decimal "value5", precision: 10, scale: 1
    t.decimal "value6", precision: 10, scale: 1
    t.decimal "value7", precision: 10, scale: 1
    t.decimal "value8", precision: 10, scale: 1
    t.decimal "value9", precision: 10, scale: 1
    t.decimal "value10", precision: 10, scale: 1
    t.decimal "value11", precision: 10, scale: 1
    t.decimal "value12", precision: 10, scale: 1
    t.decimal "value13", precision: 10, scale: 1
    t.decimal "value14", precision: 10, scale: 1
    t.decimal "value15", precision: 10, scale: 1
    t.decimal "value16", precision: 10, scale: 1
    t.decimal "value17", precision: 10, scale: 1
    t.decimal "value18", precision: 10, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "digital_values", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "value1"
    t.integer "value2"
    t.integer "value3"
    t.integer "value4"
    t.integer "value5"
    t.integer "value6"
    t.integer "value7"
    t.integer "value8"
    t.integer "value9"
    t.integer "value10"
    t.integer "value11"
    t.integer "value12"
    t.integer "value13"
    t.integer "value14"
    t.integer "value15"
    t.integer "value16"
    t.integer "value17"
    t.integer "value18"
    t.integer "value19"
    t.integer "value20"
    t.integer "value21"
    t.integer "value22"
    t.integer "value23"
    t.integer "value24"
    t.integer "value25"
    t.integer "value26"
    t.integer "value27"
    t.integer "value28"
    t.integer "value29"
    t.integer "value30"
    t.integer "value31"
    t.integer "value32"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "digitals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.integer "tile_id"
    t.string "name"
    t.integer "on_1"
    t.integer "off"
    t.integer "modbus_bit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "on_2"
    t.integer "on_3"
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

  create_table "product_tanks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "serial"
    t.string "weight"
    t.string "capacity"
    t.string "inspection_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tank_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "serial"
    t.string "capacity_filled"
    t.string "moisture_quantity"
    t.string "purity_analysis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "material_tank_serial"
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
