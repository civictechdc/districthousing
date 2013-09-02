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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130902073054) do

  create_table "housing_forms", :force => true do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "residents", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "ssn"
    t.datetime "dob"
    t.string   "gender"
    t.string   "res_street_address"
    t.string   "res_apt"
    t.string   "res_city"
    t.string   "res_state"
    t.string   "res_zip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
