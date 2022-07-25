# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_24_071013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.string "street", null: false
    t.string "postcode", null: false
    t.string "city", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "last_used"
    t.index ["employee_id"], name: "index_addresses_on_employee_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_rewards", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "reward_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_rewards_on_category_id"
    t.index ["reward_id"], name: "index_category_rewards_on_reward_id"
  end

  create_table "company_values", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_available_kudos", default: 10, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "kudos", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.bigint "giver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "receiver_id", null: false
    t.bigint "company_value_id", null: false
    t.index ["company_value_id"], name: "index_kudos_on_company_value_id"
    t.index ["giver_id"], name: "index_kudos_on_giver_id"
    t.index ["receiver_id"], name: "index_kudos_on_receiver_id"
  end

  create_table "online_codes", force: :cascade do |t|
    t.string "code"
    t.bigint "reward_id", null: false
    t.bigint "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_online_codes_on_code", unique: true
    t.index ["order_id"], name: "index_online_codes_on_order_id"
    t.index ["reward_id"], name: "index_online_codes_on_reward_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "reward_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "reward_snapshot", null: false
    t.boolean "delivered", default: false
    t.text "address_snapshot"
    t.string "delivery_type"
    t.index ["employee_id"], name: "index_orders_on_employee_id"
    t.index ["reward_id"], name: "index_orders_on_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "delivery_method", default: "online", null: false
    t.integer "available_items", default: 0
    t.integer "online_codes_count", default: 0, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "employees"
  add_foreign_key "category_rewards", "categories"
  add_foreign_key "category_rewards", "rewards"
  add_foreign_key "kudos", "company_values"
  add_foreign_key "kudos", "employees", column: "giver_id"
  add_foreign_key "online_codes", "orders"
  add_foreign_key "online_codes", "rewards"
  add_foreign_key "orders", "employees"
  add_foreign_key "orders", "rewards"
end
