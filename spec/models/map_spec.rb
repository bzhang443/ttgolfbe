require 'spec_helper'

describe Map do
  pending "add some examples to (or delete) #{__FILE__}"
end



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
#  poi_tee_red           :string(255)
#  poi_tee_white         :string(255)
#  poi_tee_blue          :string(255)
#  poi_tee_gold          :string(255)
#  poi_tee_black         :string(255)
#  position_green_center :string(255)
#  poi_green_front       :string(255)
#  poi_green_back        :string(255)
#

