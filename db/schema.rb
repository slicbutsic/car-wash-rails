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

ActiveRecord::Schema[7.1].define(version: 2025_03_16_125653) do
  create_table "bookings", force: :cascade do |t|
    t.string "phone"
    t.integer "service_id", null: false
    t.integer "vehicle_type_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_id", null: false
    t.datetime "booking_datetime"
    t.index ["price_id"], name: "index_bookings_on_price_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["vehicle_type_id"], name: "index_bookings_on_vehicle_type_id"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "price"
    t.integer "service_id", null: false
    t.integer "vehicle_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_prices_on_service_id"
    t.index ["vehicle_type_id"], name: "index_prices_on_vehicle_type_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "prices"
  add_foreign_key "bookings", "services"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "vehicle_types"
  add_foreign_key "prices", "services"
  add_foreign_key "prices", "vehicle_types"
end
