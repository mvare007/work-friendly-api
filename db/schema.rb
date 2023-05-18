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

ActiveRecord::Schema[7.0].define(version: 20_230_515_084_810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bookings', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'work_space_id', null: false
    t.datetime 'start_time', null: false
    t.datetime 'end_time', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_bookings_on_user_id'
    t.index ['work_space_id'], name: 'index_bookings_on_work_space_id'
  end

  create_table 'business_types', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_business_types_on_name', unique: true
  end

  create_table 'businesses', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'capacity'
    t.string 'phone_number'
    t.string 'email', null: false
    t.string 'address', null: false
    t.string 'zip_code', null: false
    t.string 'vat_number'
    t.string 'longitude'
    t.string 'latitude'
    t.bigint 'city_id', null: false
    t.bigint 'business_type_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['business_type_id'], name: 'index_businesses_on_business_type_id'
    t.index ['city_id'], name: 'index_businesses_on_city_id'
    t.index ['email'], name: 'index_businesses_on_email', unique: true
  end

  create_table 'businesses_facility_amenities', id: false, force: :cascade do |t|
    t.bigint 'business_id', null: false
    t.bigint 'facility_amenity_id', null: false
    t.index %w[business_id facility_amenity_id], name: 'index_bus_fac_amenities_on_bus_id_and_fac_amenity_id'
    t.index %w[facility_amenity_id business_id], name: 'index_bus_fac_amenities_on_fac_amenity_id_and_bus_id'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'country_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['country_id'], name: 'index_cities_on_country_id'
  end

  create_table 'countries', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'iso2_code'
    t.string 'iso3_code'
    t.string 'currency'
    t.string 'dialing_code'
    t.boolean 'active', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_countries_on_name', unique: true
  end

  create_table 'facility_amenities', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.bigint 'facility_amenity_category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['facility_amenity_category_id'], name: 'index_facility_amenities_on_facility_amenity_category_id'
    t.index ['name'], name: 'index_facility_amenities_on_name', unique: true
  end

  create_table 'facility_amenity_categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_facility_amenity_categories_on_name', unique: true
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'rating', default: 0, null: false
    t.text 'comment'
    t.bigint 'user_id', null: false
    t.bigint 'business_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[business_id user_id], name: 'index_reviews_on_business_id_and_user_id', unique: true
    t.index ['business_id'], name: 'index_reviews_on_business_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'schedule_days', force: :cascade do |t|
    t.integer 'weekday'
    t.time 'open_time'
    t.time 'close_time'
    t.boolean 'holiday'
    t.string 'holiday_name'
    t.bigint 'business_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['business_id'], name: 'index_schedule_days_on_business_id'
  end

  create_table 'social_links', force: :cascade do |t|
    t.integer 'platform', null: false
    t.string 'url', null: false
    t.bigint 'business_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[business_id platform], name: 'index_social_links_on_business_id_and_platform', unique: true
    t.index ['business_id'], name: 'index_social_links_on_business_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'phone_number'
    t.string 'address'
    t.string 'zip_code'
    t.string 'payment_info'
    t.datetime 'last_login'
    t.bigint 'city_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_users_on_city_id'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  create_table 'work_space_amenities', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.bigint 'work_space_amenity_category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_work_space_amenities_on_name', unique: true
    t.index ['work_space_amenity_category_id'], name: 'index_work_space_amenities_on_work_space_amenity_category_id'
  end

  create_table 'work_space_amenities_spaces', id: false, force: :cascade do |t|
    t.bigint 'work_space_id', null: false
    t.bigint 'work_space_amenity_id', null: false
    t.index %w[work_space_amenity_id work_space_id], name: 'index_ws_ws_amenities_on_ws_amenity_id_and_ws_id'
    t.index %w[work_space_id work_space_amenity_id], name: 'index_ws_ws_amenities_on_ws_id_and_ws_amenity_id'
  end

  create_table 'work_space_amenity_categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_work_space_amenity_categories_on_name', unique: true
  end

  create_table 'work_spaces', force: :cascade do |t|
    t.string 'name'
    t.integer 'capacity'
    t.decimal 'price_per_hour'
    t.time 'available_from'
    t.time 'available_to'
    t.boolean 'is_available', default: true, null: false
    t.bigint 'business_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[business_id name], name: 'index_work_spaces_on_business_id_and_name', unique: true
    t.index ['business_id'], name: 'index_work_spaces_on_business_id'
  end

  add_foreign_key 'bookings', 'users'
  add_foreign_key 'bookings', 'work_spaces'
  add_foreign_key 'businesses', 'business_types'
  add_foreign_key 'businesses', 'cities'
  add_foreign_key 'cities', 'countries'
  add_foreign_key 'facility_amenities', 'facility_amenity_categories'
  add_foreign_key 'reviews', 'businesses'
  add_foreign_key 'reviews', 'users'
  add_foreign_key 'schedule_days', 'businesses'
  add_foreign_key 'social_links', 'businesses'
  add_foreign_key 'users', 'cities'
  add_foreign_key 'work_space_amenities', 'work_space_amenity_categories'
  add_foreign_key 'work_spaces', 'businesses'
end
