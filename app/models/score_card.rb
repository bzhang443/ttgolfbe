class ScoreCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  belongs_to :course2, :class_name=>'Course'
  belongs_to :hole1, :class_name=>'Hole'
  belongs_to :hole2, :class_name=>'Hole'
  belongs_to :hole3, :class_name=>'Hole'
  belongs_to :hole4, :class_name=>'Hole'
  belongs_to :hole5, :class_name=>'Hole'
  belongs_to :hole6, :class_name=>'Hole'
  belongs_to :hole7, :class_name=>'Hole'
  belongs_to :hole8, :class_name=>'Hole'
  belongs_to :hole9, :class_name=>'Hole'
  belongs_to :hole10, :class_name=>'Hole'
  belongs_to :hole11, :class_name=>'Hole'  
  belongs_to :hole12, :class_name=>'Hole'
  belongs_to :hole13, :class_name=>'Hole'  
  belongs_to :hole14, :class_name=>'Hole'  
  belongs_to :hole15, :class_name=>'Hole'  
  belongs_to :hole16, :class_name=>'Hole'  
  belongs_to :hole17, :class_name=>'Hole'  
  belongs_to :hole18, :class_name=>'Hole'  
  
end






# == Schema Information
#
# Table name: score_cards
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  course_id  :integer(4)
#  tee_box    :string(255)
#  course2_id :integer(4)
#  start_hole :integer(4)
#  score      :integer(4)
#  hole1_id   :integer(4)
#  score1     :integer(4)
#  putts1     :integer(4)
#  t_club1    :string(255)
#  fairway1   :string(255)
#  sand1      :integer(4)
#  pty1       :integer(4)
#  hole2_id   :integer(4)
#  score2     :integer(4)
#  putts2     :integer(4)
#  t_club2    :string(255)
#  fairway2   :string(255)
#  sand2      :integer(4)
#  pty2       :integer(4)
#  hole3_id   :integer(4)
#  score3     :integer(4)
#  putts3     :integer(4)
#  t_club3    :string(255)
#  fairway3   :string(255)
#  sand3      :integer(4)
#  pty3       :integer(4)
#  hole4_id   :integer(4)
#  score4     :integer(4)
#  putts4     :integer(4)
#  t_club4    :string(255)
#  fairway4   :string(255)
#  sand4      :integer(4)
#  pty4       :integer(4)
#  hole5_id   :integer(4)
#  score5     :integer(4)
#  putts5     :integer(4)
#  t_club5    :string(255)
#  fairway5   :string(255)
#  sand5      :integer(4)
#  pty5       :integer(4)
#  hole6_id   :integer(4)
#  score6     :integer(4)
#  putts6     :integer(4)
#  t_club6    :string(255)
#  fairway6   :string(255)
#  sand6      :integer(4)
#  pty6       :integer(4)
#  hole7_id   :integer(4)
#  score7     :integer(4)
#  putts7     :integer(4)
#  t_club7    :string(255)
#  fairway7   :string(255)
#  sand7      :integer(4)
#  pty7       :integer(4)
#  hole8_id   :integer(4)
#  score8     :integer(4)
#  putts8     :integer(4)
#  t_club8    :string(255)
#  fairway8   :string(255)
#  sand8      :integer(4)
#  pty8       :integer(4)
#  hole9_id   :integer(4)
#  score9     :integer(4)
#  putts9     :integer(4)
#  t_club9    :string(255)
#  fairway9   :string(255)
#  sand9      :integer(4)
#  pty9       :integer(4)
#  hole10_id  :integer(4)
#  score10    :integer(4)
#  putts10    :integer(4)
#  t_club10   :string(255)
#  fairway10  :string(255)
#  sand10     :integer(4)
#  pty10      :integer(4)
#  hole11_id  :integer(4)
#  score11    :integer(4)
#  putts11    :integer(4)
#  t_club11   :string(255)
#  fairway11  :string(255)
#  sand11     :integer(4)
#  pty11      :integer(4)
#  hole12_id  :integer(4)
#  score12    :integer(4)
#  putts12    :integer(4)
#  t_club12   :string(255)
#  fairway12  :string(255)
#  sand12     :integer(4)
#  pty12      :integer(4)
#  hole13_id  :integer(4)
#  score13    :integer(4)
#  putts13    :integer(4)
#  t_club13   :string(255)
#  fairway13  :string(255)
#  sand13     :integer(4)
#  pty13      :integer(4)
#  hole14_id  :integer(4)
#  score14    :integer(4)
#  putts14    :integer(4)
#  t_club14   :string(255)
#  fairway14  :string(255)
#  sand14     :integer(4)
#  pty14      :integer(4)
#  hole15_id  :integer(4)
#  score15    :integer(4)
#  putts15    :integer(4)
#  t_club15   :string(255)
#  fairway15  :string(255)
#  sand15     :integer(4)
#  pty15      :integer(4)
#  hole16_id  :integer(4)
#  score16    :integer(4)
#  putts16    :integer(4)
#  t_club16   :string(255)
#  fairway16  :string(255)
#  sand16     :integer(4)
#  pty16      :integer(4)
#  hole17_id  :integer(4)
#  score17    :integer(4)
#  putts17    :integer(4)
#  t_club17   :string(255)
#  fairway17  :string(255)
#  sand17     :integer(4)
#  pty17      :integer(4)
#  hole18_id  :integer(4)
#  score18    :integer(4)
#  putts18    :integer(4)
#  t_club18   :string(255)
#  fairway18  :string(255)
#  sand18     :integer(4)
#  pty18      :integer(4)
#  openness   :string(255)     default("public")
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

