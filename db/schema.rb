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

ActiveRecord::Schema.define(version: 2019_01_09_172347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.text "name"
  end

  create_table "categories_task_lists", force: :cascade do |t|
    t.integer "category_id"
    t.integer "task_list_id"
  end

  create_table "task_lists", force: :cascade do |t|
    t.text "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "task_list_id"
    t.text "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 10
    t.integer "position"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", limit: 100, null: false
    t.string "crypted_password", limit: 40, null: false
    t.string "salt", limit: 40, null: false
    t.string "email", limit: 100, null: false
    t.string "firstname", limit: 100, null: false
    t.string "lastname", limit: 100, null: false
    t.boolean "admin"
  end

end
