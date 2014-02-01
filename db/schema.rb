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

ActiveRecord::Schema.define(version: 20140131220935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "entitlements"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consult_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "consult_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consults", force: true do |t|
    t.integer  "creator_id"
    t.integer  "customer_id"
    t.integer  "datascientist_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "scheduled_datetime"
    t.integer  "scheduled_length"
  end

  create_table "meeting_memberships", force: true do |t|
    t.integer  "meeting_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.integer  "consult_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "company_id"
    t.string   "phone_number"
    t.boolean  "alpine_user",     default: false
    t.boolean  "company_admin",   default: false
    t.boolean  "entitled",        default: false
    t.boolean  "admin",           default: false
    t.boolean  "datascientist"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
