class Course < ActiveRecord::Base
end

# == Schema Information
#
# Table name: courses
#
#  id          :integer(4)      not null, primary key
#  club_id     :integer(4)
#  name        :string(255)
#  designer    :string(255)
#  description :text
#  yards       :integer(4)
#  holes       :integer(4)
#  group_id    :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

