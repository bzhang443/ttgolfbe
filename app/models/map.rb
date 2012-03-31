class Map < ActiveRecord::Base
end

# == Schema Information
#
# Table name: maps
#
#  id               :integer(4)      not null, primary key
#  lat_left_lower   :decimal(9, 6)
#  lon_left_lower   :decimal(9, 6)
#  lat_right_lower  :decimal(9, 6)
#  lon_right_lower  :decimal(9, 6)
#  lat_left_higher  :decimal(9, 6)
#  lon_left_higher  :decimal(9, 6)
#  lat_right_higher :decimal(9, 6)
#  lon_right_higher :decimal(9, 6)
#  dim_x            :integer(4)
#  dim_y            :integer(4)
#  url              :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

