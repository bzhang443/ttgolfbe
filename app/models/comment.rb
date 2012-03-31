class Comment < ActiveRecord::Base
end

# == Schema Information
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  course_id   :integer(4)
#  user_id     :integer(4)
#  overall     :decimal(3, 1)
#  view        :decimal(3, 1)
#  hardiness   :decimal(3, 1)
#  design      :decimal(3, 1)
#  recall      :decimal(3, 1)
#  maintenance :decimal(3, 1)
#  culture     :decimal(3, 1)
#  candy       :decimal(3, 1)
#  facility    :decimal(3, 1)
#  service     :decimal(3, 1)
#  price       :decimal(3, 1)
#  notes       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

