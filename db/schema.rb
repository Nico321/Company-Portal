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

ActiveRecord::Schema.define(version: 20140226120018) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "articles", force: true do |t|
    t.string   "name"
    t.decimal  "price",              precision: 8, scale: 2
    t.integer  "delivertime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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

  create_table "carts", force: true do |t|
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

  create_table "invoices", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "installation_id"
    t.integer  "agent_id"
    t.integer  "customer_id"
    t.decimal  "installationprice"
    t.datetime "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "article_id"
    t.integer  "cart_id"
    t.integer  "line_items", default: 1
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["article_id"], name: "index_line_items_on_article_id"
  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"

  create_table "notes", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "request_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "offer_id"
    t.integer  "bugreport_id"
    t.integer  "assignment_id"
    t.integer  "order_id"
    t.integer  "installation_id"
    t.integer  "invoice_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.integer  "invoice_id"
    t.string   "status"
    t.string   "transaction_id"
    t.string   "create"
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
    t.integer  "invoice_id"
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

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
