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

ActiveRecord::Schema.define(version: 20141017062202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "address1",      null: false
    t.string   "city",          null: false
    t.string   "country",       null: false
    t.string   "state"
    t.string   "zip_code",      null: false
    t.string   "mobile_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: true do |t|
    t.string   "firstname",  null: false
    t.string   "lastname",   null: false
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title",       limit: 30,                         null: false
    t.text     "description"
    t.decimal  "price",                                          null: false
    t.integer  "in_stock",                                       null: false
    t.integer  "author_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover",                  default: "default.png", null: false
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_cards", force: true do |t|
    t.string   "number",          null: false
    t.date     "expiration_date", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id", using: :btree

  create_table "order_items", force: true do |t|
    t.decimal  "price",      null: false
    t.integer  "quantity",   null: false
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["book_id"], name: "index_order_items_on_book_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.decimal  "total_price",         default: 0.0,           null: false
    t.string   "state",               default: "in progress", null: false
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_type"
    t.string   "number"
    t.date     "completed_at"
  end

  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "ratings", force: true do |t|
    t.text     "comment"
    t.integer  "mark",       null: false
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      null: false
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                               null: false
    t.string   "firstname",                           null: false
    t.string   "lastname",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",            default: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
