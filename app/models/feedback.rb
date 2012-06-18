class Feedback < ActiveRecord::Base
end


# == Schema Information
#
# Table name: feedbacks
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  content      :string(255)
#  email        :string(255)
#  phone_number :string(255)
#  lat_lon      :string(255)
#  source       :string(255)
#  status       :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  hole_id      :integer(4)
#

