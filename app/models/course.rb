class Course < ActiveRecord::Base
  belongs_to :club
  has_many :images
  has_many :holes
  has_many :score_cards
end








# == Schema Information
#
# Table name: courses
#
#  id           :integer(4)      not null, primary key
#  club_id      :integer(4)
#  name         :string(255)
#  course_type  :string(255)
#  designer     :string(255)
#  description  :text
#  hole_count   :integer(4)
#  group_id     :integer(4)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  main_picture :string(255)
#  vip          :boolean(1)
#

