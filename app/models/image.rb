class Image < ActiveRecord::Base
end

# == Schema Information
#
# Table name: images
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  url        :string(255)
#  club_id    :integer(4)
#  course_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

