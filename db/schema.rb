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

ActiveRecord::Schema.define(version: 20140218132125) do

  create_table "article_storages", force: true do |t|
    t.integer  "article_id"
    t.integer  "storage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_storages", ["article_id"], name: "index_article_storages_on_article_id"
  add_index "article_storages", ["storage_id"], name: "index_article_storages_on_storage_id"

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "image"
    t.decimal  "price"
    t.integer  "delivertime"
    t.integer  "supplierid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.decimal  "installationprice"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bugreports", force: true do |t|
    t.string   "subject"
    t.text     "description"
    t.integer  "reporter_id"
    t.integer  "agent_id"
    t.datetime "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "installations", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.date     "installationdate"
    t.integer  "invoice_id"
    t.integer  "order_id"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.text     "imageurl"
    t.integer  "request_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "offer_id"
    t.integer  "bugreport_id"
    t.integer  "assignment_id"
    t.integer  "order_id"
    t.integer  "installation_id"
  end

  create_table "offers", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.decimal  "installationprice", default: 0.0
    t.date     "publication"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.decimal  "installationprice"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.integer  "installation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string   "zip",        limit: 5
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.integer  "quantity",      default: 1
    t.date     "deliverydate"
    t.integer  "article_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
    t.integer  "order_id"
    t.datetime "arrived"
  end

  create_table "requests", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "urgency"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storages", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip",        limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "zip",        limit: 5
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "street"
    t.string   "zip",                    limit: 5
    t.date     "absencestartdate"
    t.date     "absenceenddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
