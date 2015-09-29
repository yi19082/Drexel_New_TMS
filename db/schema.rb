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

ActiveRecord::Schema.define(version: 20150924145343) do

  create_table "colleges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "course_number", limit: 255
    t.string   "pre_req",       limit: 255
    t.string   "instructor",    limit: 255
    t.string   "day",           limit: 255
    t.string   "time",          limit: 255
    t.integer  "crn",           limit: 4
    t.string   "type",          limit: 255
    t.string   "building",      limit: 255
    t.string   "room",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "term_id",       limit: 4
    t.integer  "subject_id",    limit: 4
  end

  add_index "courses", ["term_id"], name: "index_courses_on_term_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "college_id", limit: 4
  end

  add_index "subjects", ["college_id"], name: "index_subjects_on_college_id", using: :btree

  create_table "terms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "courses", "terms"
  add_foreign_key "subjects", "colleges"
end
