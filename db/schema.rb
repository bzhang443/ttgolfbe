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

ActiveRecord::Schema.define(:version => 20120401021106) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "upper_area"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "area_id"
    t.string   "address"
    t.decimal  "latitude",    :precision => 9, :scale => 6
    t.decimal  "longitude",   :precision => 9, :scale => 6
    t.text     "description"
    t.string   "logo_url"
    t.string   "telephone"
    t.boolean  "active"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.decimal  "overall",     :precision => 3, :scale => 1
    t.decimal  "view",        :precision => 3, :scale => 1
    t.decimal  "hardiness",   :precision => 3, :scale => 1
    t.decimal  "design",      :precision => 3, :scale => 1
    t.decimal  "recall",      :precision => 3, :scale => 1
    t.decimal  "maintenance", :precision => 3, :scale => 1
    t.decimal  "culture",     :precision => 3, :scale => 1
    t.decimal  "candy",       :precision => 3, :scale => 1
    t.decimal  "facility",    :precision => 3, :scale => 1
    t.decimal  "service",     :precision => 3, :scale => 1
    t.decimal  "price",       :precision => 3, :scale => 1
    t.string   "notes"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.string   "designer"
    t.text     "description"
    t.integer  "yards"
    t.integer  "holes"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "did"
    t.string   "model"
    t.string   "os"
    t.string   "version"
    t.string   "source"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "holes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.integer  "par"
    t.integer  "yard_black"
    t.integer  "yard_gold"
    t.integer  "yard_blue"
    t.integer  "yard_white"
    t.integer  "yard_red"
    t.integer  "map_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "club_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "maps", :force => true do |t|
    t.decimal  "lat_left_lower",   :precision => 9, :scale => 6
    t.decimal  "lon_left_lower",   :precision => 9, :scale => 6
    t.decimal  "lat_right_lower",  :precision => 9, :scale => 6
    t.decimal  "lon_right_lower",  :precision => 9, :scale => 6
    t.decimal  "lat_left_higher",  :precision => 9, :scale => 6
    t.decimal  "lon_left_higher",  :precision => 9, :scale => 6
    t.decimal  "lat_right_higher", :precision => 9, :scale => 6
    t.decimal  "lon_right_higher", :precision => 9, :scale => 6
    t.integer  "dim_x"
    t.integer  "dim_y"
    t.string   "url"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "prices", :force => true do |t|
    t.integer  "course_id"
    t.string   "time_slot"
    t.decimal  "price",      :precision => 9, :scale => 2
    t.integer  "agent_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.string   "sina_token"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
