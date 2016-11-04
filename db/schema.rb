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

ActiveRecord::Schema.define(version: 20161104035444) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "product_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "number"
    t.datetime "time"
    t.string   "people"
    t.string   "order_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "price"
    t.string   "status"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "order_item_id"
    t.string   "name"
    t.text     "remark"
    t.string   "shop_count"
    t.boolean  "off_self"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "serves", force: :cascade do |t|
    t.string   "server_name"
    t.string   "server_level"
    t.string   "server_money"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "set_meals", force: :cascade do |t|
    t.integer  "vip_type_id"
    t.string   "type"
    t.string   "cost"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vip_lvs", force: :cascade do |t|
    t.integer  "vip_type_id"
    t.integer  "set_meal_id"
    t.string   "level"
    t.string   "standard"
    t.string   "rights"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vip_records", force: :cascade do |t|
    t.string   "name"
    t.integer  "sex",               default: 0
    t.string   "address"
    t.datetime "birthday"
    t.string   "identity_card"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "emergency_contact"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "vip_types", force: :cascade do |t|
    t.string   "vip_type"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wechat_users", force: :cascade do |t|
    t.string   "open_id"
    t.string   "nickname"
    t.string   "headimgurl"
    t.integer  "subscribe"
    t.text     "access_token_info"
    t.text     "auth_hash"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
