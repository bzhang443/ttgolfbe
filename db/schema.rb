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

ActiveRecord::Schema.define(:version => 20120517024344) do

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
    t.decimal  "latitude",     :precision => 9, :scale => 6
    t.decimal  "longitude",    :precision => 9, :scale => 6
    t.text     "description"
    t.string   "logo_url"
    t.string   "telephone"
    t.boolean  "active",                                     :default => true
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.text     "comments"
    t.integer  "updated_flag",                               :default => 0
  end

  add_index "clubs", ["area_id"], :name => "FK_club_area"

  create_table "comments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.decimal  "overall",     :precision => 3, :scale => 1
    t.decimal  "view",        :precision => 3, :scale => 1
    t.decimal  "hardness",    :precision => 3, :scale => 1
    t.decimal  "design",      :precision => 3, :scale => 1
    t.decimal  "maintenance", :precision => 3, :scale => 1
    t.decimal  "rational",    :precision => 3, :scale => 1
    t.decimal  "candy",       :precision => 3, :scale => 1
    t.decimal  "facility",    :precision => 3, :scale => 1
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
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "main_picture"
    t.integer  "updated_flag", :default => 0
  end

  add_index "courses", ["club_id"], :name => "FK_course_club"
  add_index "courses", ["group_id"], :name => "FK_course_group"

  create_table "credit_histories", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "offset"
    t.integer  "course_id"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  add_index "devices", ["did"], :name => "index_devices_on_did", :unique => true
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
    t.string   "poi_tee_red"
    t.string   "poi_tee_white"
    t.string   "poi_tee_blue"
    t.string   "poi_tee_gold"
    t.string   "poi_tee_black"
    t.string   "poi_green_center"
    t.string   "poi_green_front"
    t.string   "poi_green_back"
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

  create_table "score_cards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "tee_box"
    t.integer  "course2_id"
    t.integer  "start_hole"
    t.integer  "score"
    t.integer  "hole1_id"
    t.integer  "score1"
    t.integer  "putts1"
    t.string   "t_club1"
    t.string   "fairway1"
    t.integer  "sand1"
    t.integer  "pty1"
    t.integer  "hole2_id"
    t.integer  "score2"
    t.integer  "putts2"
    t.string   "t_club2"
    t.string   "fairway2"
    t.integer  "sand2"
    t.integer  "pty2"
    t.integer  "hole3_id"
    t.integer  "score3"
    t.integer  "putts3"
    t.string   "t_club3"
    t.string   "fairway3"
    t.integer  "sand3"
    t.integer  "pty3"
    t.integer  "hole4_id"
    t.integer  "score4"
    t.integer  "putts4"
    t.string   "t_club4"
    t.string   "fairway4"
    t.integer  "sand4"
    t.integer  "pty4"
    t.integer  "hole5_id"
    t.integer  "score5"
    t.integer  "putts5"
    t.string   "t_club5"
    t.string   "fairway5"
    t.integer  "sand5"
    t.integer  "pty5"
    t.integer  "hole6_id"
    t.integer  "score6"
    t.integer  "putts6"
    t.string   "t_club6"
    t.string   "fairway6"
    t.integer  "sand6"
    t.integer  "pty6"
    t.integer  "hole7_id"
    t.integer  "score7"
    t.integer  "putts7"
    t.string   "t_club7"
    t.string   "fairway7"
    t.integer  "sand7"
    t.integer  "pty7"
    t.integer  "hole8_id"
    t.integer  "score8"
    t.integer  "putts8"
    t.string   "t_club8"
    t.string   "fairway8"
    t.integer  "sand8"
    t.integer  "pty8"
    t.integer  "hole9_id"
    t.integer  "score9"
    t.integer  "putts9"
    t.string   "t_club9"
    t.string   "fairway9"
    t.integer  "sand9"
    t.integer  "pty9"
    t.integer  "hole10_id"
    t.integer  "score10"
    t.integer  "putts10"
    t.string   "t_club10"
    t.string   "fairway10"
    t.integer  "sand10"
    t.integer  "pty10"
    t.integer  "hole11_id"
    t.integer  "score11"
    t.integer  "putts11"
    t.string   "t_club11"
    t.string   "fairway11"
    t.integer  "sand11"
    t.integer  "pty11"
    t.integer  "hole12_id"
    t.integer  "score12"
    t.integer  "putts12"
    t.string   "t_club12"
    t.string   "fairway12"
    t.integer  "sand12"
    t.integer  "pty12"
    t.integer  "hole13_id"
    t.integer  "score13"
    t.integer  "putts13"
    t.string   "t_club13"
    t.string   "fairway13"
    t.integer  "sand13"
    t.integer  "pty13"
    t.integer  "hole14_id"
    t.integer  "score14"
    t.integer  "putts14"
    t.string   "t_club14"
    t.string   "fairway14"
    t.integer  "sand14"
    t.integer  "pty14"
    t.integer  "hole15_id"
    t.integer  "score15"
    t.integer  "putts15"
    t.string   "t_club15"
    t.string   "fairway15"
    t.integer  "sand15"
    t.integer  "pty15"
    t.integer  "hole16_id"
    t.integer  "score16"
    t.integer  "putts16"
    t.string   "t_club16"
    t.string   "fairway16"
    t.integer  "sand16"
    t.integer  "pty16"
    t.integer  "hole17_id"
    t.integer  "score17"
    t.integer  "putts17"
    t.string   "t_club17"
    t.string   "fairway17"
    t.integer  "sand17"
    t.integer  "pty17"
    t.integer  "hole18_id"
    t.integer  "score18"
    t.integer  "putts18"
    t.string   "t_club18"
    t.string   "fairway18"
    t.integer  "sand18"
    t.integer  "pty18"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.string   "sina_token"
    t.boolean  "active",       :default => true
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "sina_expires"
    t.string   "sina_uid"
    t.integer  "credit",       :default => 0
    t.string   "tee"
    t.string   "score_mode"
  end

end
