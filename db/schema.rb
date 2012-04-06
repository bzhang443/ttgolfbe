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

ActiveRecord::Schema.define(:version => 20120406104203) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

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

  add_index "areas", ["upper_area"], :name => "FK_areas_upper"

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
    t.boolean  "active",                                    :default => true
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "clubs", ["area_id"], :name => "FK_club_area"

  create_table "comments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.decimal  "overall",     :precision => 3, :scale => 1
    t.decimal  "view",        :precision => 3, :scale => 1
    t.decimal  "hardness",    :precision => 3, :scale => 1
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

  add_index "comments", ["course_id"], :name => "FK_comment_course"
  add_index "comments", ["user_id"], :name => "FK_comment_user"

  create_table "courses", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.string   "course_type"
    t.string   "designer"
    t.text     "description"
    t.integer  "hole_count"
    t.integer  "group_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "main_picture"
  end

  add_index "courses", ["club_id"], :name => "FK_course_club"
  add_index "courses", ["group_id"], :name => "FK_course_group"

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

  add_index "devices", ["user_id"], :name => "FK_device_user"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["course_id"], :name => "FK_favorite_course"
  add_index "favorites", ["user_id"], :name => "FK_favorite_user"

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

  add_index "holes", ["course_id"], :name => "FK_hole_course"
  add_index "holes", ["map_id"], :name => "FK_hole_map"

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "club_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "images", ["club_id"], :name => "FK_image_club"
  add_index "images", ["course_id"], :name => "FK_image_course"

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

  add_index "prices", ["agent_id"], :name => "FK_price_agent"
  add_index "prices", ["course_id"], :name => "FK_price_course"

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
