class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  before_save :update_overall
  
private
  def update_overall
    self.overall = (self.view + self.hardness + self.design + self.maintenance + self.rational + self.candy + self.facility + self.price)/10
  end
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
#  hardness    :decimal(3, 1)
#  design      :decimal(3, 1)
#  maintenance :decimal(3, 1)
#  rational    :decimal(3, 1)
#  candy       :decimal(3, 1)
#  facility    :decimal(3, 1)
#  price       :decimal(3, 1)
#  notes       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

