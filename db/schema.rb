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

ActiveRecord::Schema.define(version: 20180301195935) do

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.boolean  "hidden",     default: false
    t.datetime "created"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.boolean  "hidden",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.boolean  "hidden",         default: false
    t.integer  "subcategory_id"
    t.string   "unit"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id", using: :btree
  end

  create_table "purchases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.boolean  "hidden",                default: false
    t.float    "price",      limit: 24
    t.float    "amount",     limit: 24
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["cart_id"], name: "index_purchases_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_purchases_on_product_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_roles_on_user_id", using: :btree
  end

  create_table "subcategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.boolean  "hidden",      default: false
    t.integer  "category_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "products", "subcategories"
  add_foreign_key "purchases", "carts"
  add_foreign_key "purchases", "products"
  add_foreign_key "roles", "users"
  add_foreign_key "subcategories", "categories"
end
