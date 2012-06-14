class Area < ActiveRecord::Base
  belongs_to :upper, :foreign_key=>'upper_area', :class_name=>'Area'
  has_many :subs, :foreign_key=>'upper_area', :class_name=>'Area'
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

