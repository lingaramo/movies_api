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

ActiveRecord::Schema.define(version: 2018_11_22_133623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casting", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "movie_id", null: false
    t.index ["movie_id", "person_id"], name: "index_casting_on_movie_id_and_person_id"
    t.index ["person_id", "movie_id"], name: "index_casting_on_person_id_and_movie_id"
  end

  create_table "directors", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "movie_id", null: false
    t.index ["movie_id", "person_id"], name: "index_directors_on_movie_id_and_person_id"
    t.index ["person_id", "movie_id"], name: "index_directors_on_person_id_and_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.integer "release_year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "alias", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "producers", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "movie_id", null: false
    t.index ["movie_id", "person_id"], name: "index_producers_on_movie_id_and_person_id"
    t.index ["person_id", "movie_id"], name: "index_producers_on_person_id_and_movie_id"
  end

end
