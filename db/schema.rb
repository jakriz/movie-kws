# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171113214902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "genres", ["name"], name: "index_genres_on_name", unique: true, using: :btree

  create_table "genres_movies", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  add_index "genres_movies", ["genre_id"], name: "index_genres_movies_on_genre_id", using: :btree
  add_index "genres_movies", ["movie_id"], name: "index_genres_movies_on_movie_id", using: :btree

  create_table "keywords", force: :cascade do |t|
    t.string   "word",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "movies_count", default: 0
  end

  add_index "keywords", ["word", "movies_count"], name: "index_keywords_on_word_and_movies_count", using: :btree
  add_index "keywords", ["word"], name: "index_keywords_on_word", unique: true, using: :btree

  create_table "keywords_movies", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "movie_id"
  end

  add_index "keywords_movies", ["keyword_id"], name: "index_keywords_movies_on_keyword_id", using: :btree
  add_index "keywords_movies", ["movie_id"], name: "index_keywords_movies_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.integer  "imdb_id",               null: false
    t.string   "title",                 null: false
    t.integer  "year",                  null: false
    t.integer  "rank_for_year",         null: false
    t.decimal  "gross_amount"
    t.decimal  "gross_amount_adjusted"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "movies", ["year"], name: "index_movies_on_year", using: :btree

  add_foreign_key "genres_movies", "genres"
  add_foreign_key "genres_movies", "movies"
  add_foreign_key "keywords_movies", "keywords"
  add_foreign_key "keywords_movies", "movies"
end
