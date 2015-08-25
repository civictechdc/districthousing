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

ActiveRecord::Schema.define(version: 20150825093953) do

  create_table "addresses", force: true do |t|
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "apt"
    t.integer "applicant_id"
  end

  create_table "aliases", force: true do |t|
    t.string  "name"
    t.integer "person_id"
  end

  create_table "applicants", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "identity_id"
  end

  add_index "applicants", ["user_id"], name: "index_applicants_on_user_id"

  create_table "applicants_housing_forms", id: false, force: true do |t|
    t.integer "applicant_id"
    t.integer "housing_form_id"
  end

  create_table "contacts", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "person_id"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_type"
  end

  add_index "contacts", ["applicant_id"], name: "index_contacts_on_applicant_id"
  add_index "contacts", ["person_id"], name: "index_contacts_on_person_id"

  create_table "criminal_histories", force: true do |t|
    t.integer  "person_id"
    t.string   "description"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crime_type"
  end

  create_table "employments", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "employer_name"
    t.string   "supervisor_name"
    t.string   "position"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current"
    t.integer  "person_id"
    t.integer  "address_id"
    t.integer  "applicant_id"
  end

  add_index "employments", ["address_id"], name: "index_employments_on_address_id"
  add_index "employments", ["applicant_id"], name: "index_employments_on_applicant_id"
  add_index "employments", ["person_id"], name: "index_employments_on_person_id"

  create_table "form_fields", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_fields_housing_forms", id: false, force: true do |t|
    t.integer "form_field_id"
    t.integer "housing_form_id"
  end

  create_table "household_members", force: true do |t|
    t.integer "applicant_id"
    t.integer "person_id"
    t.string  "relationship"
  end

  add_index "household_members", ["applicant_id"], name: "index_household_members_on_applicant_id"
  add_index "household_members", ["person_id"], name: "index_household_members_on_person_id"

  create_table "housing_forms", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "remote_id"
    t.boolean  "updated_locally"
  end

  create_table "identities", id: false, force: true do |t|
    t.integer "applicant_id", null: false
    t.integer "person_id",    null: false
  end

  create_table "incomes", force: true do |t|
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.string   "interval"
    t.string   "income_type"
  end

  add_index "incomes", ["person_id"], name: "index_incomes_on_person_id"

  create_table "mail", id: false, force: true do |t|
    t.integer "person_id",  null: false
    t.integer "address_id", null: false
  end

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "ssn"
    t.datetime "dob"
    t.string   "gender"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "citizenship"
    t.string   "country_of_birth"
    t.string   "email"
    t.string   "race"
    t.string   "student_status"
    t.string   "marital_status"
    t.integer  "applicant_id"
    t.string   "occupation"
    t.integer  "mail_address_id"
    t.string   "state_of_birth"
    t.string   "city_of_birth"
    t.string   "driver_license_number"
    t.string   "driver_license_state"
    t.string   "ethnicity"
    t.datetime "driver_license_exp_date"
  end

  create_table "previous_ssns", force: true do |t|
    t.string   "number"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residences", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "address_id"
    t.date     "start"
    t.date     "end"
    t.string   "reason"
    t.integer  "landlord_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current"
    t.integer  "rent"
  end

  add_index "residences", ["address_id"], name: "index_residences_on_address_id"
  add_index "residences", ["applicant_id"], name: "index_residences_on_applicant_id"
  add_index "residences", ["landlord_id"], name: "index_residences_on_landlord_id"

  create_table "salesforce_applicants", force: true do |t|
    t.integer "applicant_id"
    t.string  "name"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
