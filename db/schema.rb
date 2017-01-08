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

ActiveRecord::Schema.define(version: 20170106224012) do

  create_table "cars", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "brand"
    t.string   "model"
    t.string   "chassis_number"
    t.string   "engine_number"
    t.string   "plate"
    t.integer  "kilometers"
    t.date     "sell_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["client_id"], name: "index_cars_on_client_id"
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.integer  "telephone"
    t.integer  "ci"
    t.integer  "ruc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_clients_on_city_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manuals", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "operation_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["car_id"], name: "index_manuals_on_car_id"
  end

  create_table "repair_orders", force: :cascade do |t|
    t.integer  "car_id"
    t.integer  "order_number"
    t.integer  "claim_number"
    t.string   "operation_number"
    t.string   "description"
    t.string   "type"
    t.boolean  "ajax"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["car_id"], name: "index_repair_orders_on_car_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "technical_reports", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_technical_reports_on_car_id"
  end

end
