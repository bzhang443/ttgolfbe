class Area < ActiveRecord::Base
end

# == Schema Information
#
# Table name: areas
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  level      :integer(4)
#  upper_area :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

