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

ActiveRecord::Schema.define(version: 2024_07_16_133037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "pgsodium"
  enable_extension "plpgsql"
  enable_extension "supabase_vault"
  enable_extension "uuid-ossp"

  create_table "activities", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.string "title"
    t.string "description"
    t.string "photo"
    t.integer "price"
    t.decimal "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "view_id"
    t.string "place"
    t.string "theme"
    t.string "duration"
    t.index ["city_id"], name: "index_activities_on_city_id"
  end

  create_table "activity_views", force: :cascade do |t|
    t.bigint "visitor_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.decimal "price"
    t.decimal "rating"
    t.string "place"
    t.string "theme"
    t.string "duration"
    t.decimal "user_rating"
    t.index ["activity_id"], name: "index_activity_views_on_activity_id"
    t.index ["visitor_id"], name: "index_activity_views_on_visitor_id"
  end

  create_table "app_tasks", force: :cascade do |t|
    t.string "address"
    t.datetime "date"
    t.text "description"
    t.integer "amount_coins"
    t.bigint "app_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title"
    t.integer "post_code"
    t.boolean "completed"
    t.float "latitude"
    t.float "longitude"
    t.string "photo"
    t.index ["app_user_id"], name: "index_app_tasks_on_app_user_id"
  end

  create_table "app_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name"
    t.integer "rating"
    t.integer "coins", default: 5
    t.string "address"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.text "bio"
    t.string "city"
    t.text "quote"
    t.index ["email"], name: "index_app_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_app_users_on_reset_password_token", unique: true
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "phone"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "view_id"
  end

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "restaurant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_comments_on_restaurant_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "cocktail_id"
    t.bigint "ingredient_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cocktail_id"], name: "index_doses_on_cocktail_id"
    t.index ["ingredient_id"], name: "index_doses_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string "state"
    t.bigint "app_user_id"
    t.bigint "app_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed_by_owner"
    t.boolean "completed_by_helper"
    t.text "comments"
    t.index ["app_task_id"], name: "index_offers_on_app_task_id"
    t.index ["app_user_id"], name: "index_offers_on_app_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "rating"
    t.bigint "app_user_id"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_user_id"], name: "index_reviews_on_app_user_id"
    t.index ["offer_id"], name: "index_reviews_on_offer_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.check_constraint "(email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)", name: "users_email_change_confirm_status_check"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_visitors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_visitors_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "cities"
  add_foreign_key "activity_views", "activities"
  add_foreign_key "activity_views", "visitors"
  add_foreign_key "app_tasks", "app_users"
  add_foreign_key "comments", "restaurants"
  add_foreign_key "comments", "users"
  add_foreign_key "doses", "cocktails"
  add_foreign_key "doses", "ingredients"
  add_foreign_key "offers", "app_tasks"
  add_foreign_key "offers", "app_users"
  add_foreign_key "restaurants", "users"
  add_foreign_key "reviews", "app_users"
  add_foreign_key "reviews", "offers"
end
