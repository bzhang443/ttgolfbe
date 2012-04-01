class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
end

# == Schema Information
#
# Table name: favorites
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  course_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

