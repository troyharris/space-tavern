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

ActiveRecord::Schema[7.1].define(version: 2024_06_09_175136) do
  create_table "events", force: :cascade do |t|
    t.integer "day", null: false
    t.integer "time", null: false
    t.string "event_type", null: false
    t.string "description", null: false
    t.boolean "is_visiting", default: false, null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_events_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "day", default: 1, null: false
    t.string "history"
    t.float "tavern_popularity", default: 0.1, null: false
    t.float "colony_prosperity", default: 0.1, null: false
    t.integer "credits", default: 100, null: false
    t.integer "beer_cost", default: 5, null: false
    t.integer "beer_sell_price", default: 10, null: false
    t.integer "beers_in_stock", default: 10, null: false
    t.datetime "current_time", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.float "event_probability", default: 0.7, null: false
    t.boolean "is_event_triggered", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "day", null: false
    t.integer "time", null: false
    t.string "type", null: false
    t.string "message"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_messages_on_game_id"
  end

  create_table "patron_relationships", force: :cascade do |t|
    t.integer "patron_id", null: false
    t.integer "other_patron_id", null: false
    t.float "affinity", default: 0.5, null: false
    t.string "shared_history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["other_patron_id"], name: "index_patron_relationships_on_other_patron_id"
    t.index ["patron_id"], name: "index_patron_relationships_on_patron_id"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "name", null: false
    t.string "job", null: false
    t.integer "credits", null: false
    t.string "description", null: false
    t.integer "age", null: false
    t.float "enjoys_tavern", default: 0.1, null: false
    t.boolean "is_visiting", default: false, null: false
    t.integer "visit_length", default: 0, null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_patrons_on_game_id"
  end

  add_foreign_key "events", "games"
  add_foreign_key "messages", "games"
  add_foreign_key "patron_relationships", "patrons"
  add_foreign_key "patron_relationships", "patrons", column: "other_patron_id"
  add_foreign_key "patrons", "games"
end
