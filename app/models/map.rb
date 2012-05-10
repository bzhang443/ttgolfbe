class Map < ActiveRecord::Base
  has_one :hole
end


#INSERT INTO `maps` (`id`, `lat_left_lower`, `lon_left_lower`, `lat_right_lower`, `lon_right_lower`, `lat_left_higher`, `lon_left_higher`, `lat_right_higher`, `lon_right_higher`, `dim_x`, `dim_y`, `url`, `created_at`, `updated_at`, `position_tee_red`, `position_tee_white`, `position_tee_blue`, `position_tee_gold`, `position_tee_black`, `position_green_center`)
#VALUES
#	(76, 39.879890, 116.526908, 39.879838, 116.527920, 39.883897, 116.527259, 39.883844, 116.528271, 127, 622, 'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430172330913.jpg', '2012-03-28 11:08:38', '2012-03-28 11:08:38', '51|436', '55|471', '60|506', '68|536', '71|570', '66|42');


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

