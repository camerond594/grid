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

ActiveRecord::Schema[7.0].define(version: 2023_03_09_193203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constructors", force: :cascade do |t|
    t.string "name"
    t.string "nationality"
    t.string "url"
  end

  create_table "driver_seasons", force: :cascade do |t|
    t.bigint "driver_id"
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "constructor_id"
    t.index ["constructor_id"], name: "index_driver_seasons_on_constructor_id"
    t.index ["driver_id"], name: "index_driver_seasons_on_driver_id"
    t.index ["season_id"], name: "index_driver_seasons_on_season_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "driver_id"
    t.string "code"
    t.string "url"
    t.integer "permanent_number"
    t.string "given_name"
    t.string "family_name"
    t.date "date_of_birth"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "year"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "driver_seasons", "constructors"
end
