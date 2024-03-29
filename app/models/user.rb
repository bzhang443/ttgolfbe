class User < ActiveRecord::Base
  has_many :devices
  has_many :credit_histories
  has_many :score_cards
  has_attached_file :avatar, :styles => {:thumb=> "100x100#", :small  => "400x400>" }
  
  def self.secure_get(name, password)
    u = User.find_by_name name
    return nil unless u
    return u if password.eql?(u.password)
    nil
  end
  
  def add_credit(action, offset, options)
    his = CreditHistory.create({:user_id=>self.id, :action=>action, :offset=>offset}.merge(options))
    his.save
    self.credit += offset
    self.save
  end
  
end







# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)
#  email               :string(255)
#  password            :string(255)
#  salt                :string(255)
#  sina_token          :string(255)
#  active              :boolean(1)      default(TRUE)
#  sina_expires        :datetime
#  sina_uid            :string(255)
#  credit              :integer(4)      default(0)
#  tee                 :string(255)
#  score_mode          :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#

