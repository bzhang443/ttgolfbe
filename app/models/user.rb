class User < ActiveRecord::Base
  has_many :devices
  def self.secure_get(name, password)
    u = User.find_by_name name
    return nil unless u
    return u if password.eql?(u.password)
    nil
  end
end




# == Schema Information
#
# Table name: users
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  email        :string(255)
#  password     :string(255)
#  salt         :string(255)
#  sina_token   :string(255)
#  active       :boolean(1)      default(TRUE)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  sina_expires :datetime
#  sina_uid     :string(255)
#

