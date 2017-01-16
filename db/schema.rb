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

ActiveRecord::Schema.define(version: 20170116105323) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "stop_time"
  end

  create_table "activity_rules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rule"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "activity_id"
    t.decimal  "max",           precision: 10, scale: 3
    t.decimal  "min",           precision: 10, scale: 3
    t.decimal  "y_coin",        precision: 10
    t.integer  "scoin_type_id"
  end

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "contact_name"
    t.string   "mobile"
    t.boolean  "is_default",     default: false
    t.string   "detail"
    t.string   "province"
    t.string   "city"
    t.string   "street"
    t.integer  "wechat_user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["wechat_user_id"], name: "index_addresses_on_wechat_user_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "role_name",              default: "member"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "blood_glucoses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "examine_record_id"
    t.integer  "wechat_user_id"
    t.float    "ante_cibum",        limit: 24
    t.float    "after_a_meal",      limit: 24
  end

  create_table "blood_pressures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "examine_record_id"
    t.integer  "wechat_user_id"
    t.float    "diastolic_pressure", limit: 24
    t.float    "systolic_pressure",  limit: 24
  end

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "wechat_user_id"
    t.index ["wechat_user_id"], name: "index_carts_on_wechat_user_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "examine_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "idcard"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "user_id"
  end

  create_table "health_examines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identity_card"
    t.datetime "time"
    t.string   "coding"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "product",       limit: 65535
  end

  create_table "heart_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "examine_record_id"
    t.integer  "wechat_user_id"
    t.integer  "value"
  end

  create_table "house_poperties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "house_name"
    t.string   "unit"
    t.float    "price",          limit: 24
    t.float    "total",          limit: 24
    t.string   "discount"
    t.float    "discount_price", limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "line_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.integer "quantity",                            default: 1
    t.integer "order_id"
    t.boolean "in_cart",                             default: true
    t.decimal "unit_price", precision: 10, scale: 2
    t.index ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_line_items_on_product_id", using: :btree
  end

  create_table "long_programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "doctor"
    t.string   "hospital"
    t.string   "recipe_number"
    t.decimal  "total",         precision: 10
    t.string   "detail"
    t.integer  "blood_letting"
    t.integer  "treatment"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "identity_card"
    t.string   "level"
    t.datetime "time"
  end

  create_table "member_clubs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "vip_type_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "member_equities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number_of_time"
    t.integer  "number"
    t.integer  "serve_id"
    t.integer  "product_id"
    t.integer  "membership_card_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "remark",             limit: 65535
    t.decimal  "price",                            precision: 10
  end

  create_table "member_ranks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "vip_type_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "member_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "member_number"
    t.datetime "initiation_time"
    t.string   "affiliation"
    t.integer  "membership_card_id"
  end

  create_table "membership_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "setmeal_id"
    t.integer  "serve_id"
    t.integer  "house_poperty_id"
    t.integer  "stock_right_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "desc",             limit: 65535
    t.integer  "member_club_id"
    t.float    "discount",         limit: 24
    t.integer  "allowance"
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_number"
    t.string   "expressage_type"
    t.string   "way"
    t.string   "Logistics_type"
    t.integer  "order_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "wechat_user_id"
    t.integer  "address_id"
    t.string   "status",                                  default: "pending"
    t.integer  "quantity"
    t.decimal  "price",          precision: 10, scale: 2
    t.string   "trade_nos"
    t.string   "refund_reason"
    t.decimal  "refund_price",   precision: 10, scale: 2
    t.string   "number"
    t.string   "express_number"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.index ["address_id"], name: "index_orders_on_address_id", using: :btree
    t.index ["wechat_user_id"], name: "index_orders_on_wechat_user_id", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "price",         limit: 24
    t.string   "status"
    t.string   "way"
    t.integer  "order_id"
    t.integer  "order_item_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.decimal  "original_product_price",               precision: 10, scale: 2
    t.decimal  "now_product_price",                    precision: 10, scale: 2
    t.boolean  "is_show"
    t.string   "standard"
    t.string   "product_sort"
    t.string   "packaging"
    t.string   "production"
    t.string   "weight"
    t.string   "standard_number"
    t.string   "serial_number"
    t.text     "desc",                   limit: 65535
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.integer  "shop_count",                                                    default: 0
    t.integer  "lock_shop_count",                                               default: 0
    t.string   "only_number"
  end

  create_table "ranks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receiver_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "receiver_address"
    t.string   "receiver"
    t.string   "receiver_telphone"
    t.string   "receiver_type"
    t.string   "receiver_date"
    t.string   "receiver_company"
    t.integer  "order_item_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "reservation_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "service_staff_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "spine_build_id"
    t.string   "identity_card"
  end

  create_table "return_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "line_item_id"
    t.integer  "order_id"
    t.integer  "quantity",                   default: 1
    t.text     "desc",         limit: 65535
    t.integer  "tp",                         default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["line_item_id"], name: "index_return_requests_on_line_item_id", using: :btree
    t.index ["order_id"], name: "index_return_requests_on_order_id", using: :btree
  end

  create_table "scoin_account_order_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "order_id"
    t.integer  "scoin_account_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "scoin_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "account"
    t.string   "password"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "number",     precision: 10, scale: 1
  end

  create_table "scoin_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "state"
    t.integer  "scoin_account_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "scoin_type_id"
    t.datetime "start_at"
    t.datetime "end_at"
  end

  create_table "scoin_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "once"
    t.decimal  "everyday",      precision: 10, scale: 1
    t.decimal  "count",         precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "remain_count",  precision: 10
    t.decimal  "present_count", precision: 10
  end

  create_table "sender_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sender"
    t.string   "sender_address"
    t.string   "sender_telphone"
    t.string   "sender_date"
    t.string   "sender_type"
    t.string   "sender_company"
    t.integer  "order_item_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "serves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "serve_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  create_table "service_staffs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_meal_serve_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "server_id"
    t.integer  "setmeal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setmeals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.text     "content",    limit: 65535
    t.string   "type"
    t.float    "const",      limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "slides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "desc"
    t.string   "url"
    t.string   "image"
    t.boolean  "is_show"
    t.integer  "weight"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "tp",         default: 1
  end

  create_table "spine_builds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "workstation_id"
    t.integer  "rank_id"
    t.integer  "serve_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stock_rights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "count"
    t.string   "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temperatures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "value",             limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "examine_record_id"
    t.integer  "wechat_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "password"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "telphone"
    t.string   "identity_card"
    t.integer  "integral"
    t.integer  "scoin_account_id"
    t.decimal  "y_coin",           precision: 10
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "vip_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.string   "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wechat_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "open_id"
    t.string   "nickname",          limit: 250
    t.string   "headimgurl"
    t.integer  "subscribe"
    t.text     "access_token_info", limit: 16777215
    t.text     "auth_hash",         limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "mobile"
    t.integer  "used_address_id"
    t.integer  "user_id"
  end

  create_table "weights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "value",             limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "examine_record_id"
    t.integer  "wechat_user_id"
    t.string   "height"
  end

  create_table "workstations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
