class CreditHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :club
  
end

# == Schema Information
#
# Table name: credit_histories
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  action     :string(255)
#  offset     :integer(4)
#  course_id  :integer(4)
#  club_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

