class Map < ActiveRecord::Base
  has_one :hole
end


# 
# update maps 
# set position_green_center = '55|80',
#  position_tee_red = '106|548', 
#  position_tee_white = '112|596',
#  position_tee_blue = '118|633',
#  position_tee_gold = '129|667',
#  position_tee_black = '132|699'
# where id=76;

# == Schema Information
#
# Table name: maps
#
#  id                    :integer(4)      not null, primary key
#  lat_left_lower        :decimal(9, 6)
#  lon_left_lower        :decimal(9, 6)
#  lat_right_lower       :decimal(9, 6)
#  lon_right_lower       :decimal(9, 6)
#  lat_left_higher       :decimal(9, 6)
#  lon_left_higher       :decimal(9, 6)
#  lat_right_higher      :decimal(9, 6)
#  lon_right_higher      :decimal(9, 6)
#  dim_x                 :integer(4)
#  dim_y                 :integer(4)
#  url                   :string(255)
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  position_tee_red      :string(255)
#  position_tee_white    :string(255)
#  position_tee_blue     :string(255)
#  position_tee_gold     :string(255)
#  position_tee_black    :string(255)
#  position_green_center :string(255)
#

