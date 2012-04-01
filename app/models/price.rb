class Price < ActiveRecord::Base
  belongs_to :agent
  belongs_to :course
end

# == Schema Information
#
# Table name: prices
#
#  id         :integer(4)      not null, primary key
#  course_id  :integer(4)
#  time_slot  :string(255)
#  price      :decimal(9, 2)
#  agent_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

