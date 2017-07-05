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

ActiveRecord::Schema.define(version: 20170628203317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_bases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "primary_courses", force: :cascade do |t|
    t.string   "dept"
    t.string   "number"
    t.string   "section"
    t.string   "name"
    t.string   "description"
    t.string   "title"
    t.string   "designation"
    t.text     "course_details"
    t.string   "prerequisites"
    t.string   "units"
    t.string   "term"
    t.string   "instructor_name"
    t.string   "instructor_email"
    t.string   "short_note"
    t.string   "delivery_method"
    t.string   "schedule"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "schedule_builders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secondary_courses", force: :cascade do |t|
    t.string   "dept"
    t.string   "number"
    t.string   "section"
    t.string   "name"
    t.string   "description"
    t.string   "title"
    t.string   "designation"
    t.text     "course_details"
    t.string   "prerequisites"
    t.string   "units"
    t.string   "term"
    t.string   "delivery_method"
    t.string   "schedule"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "primary_course_id"
  end

end
