class User < ActiveRecord::Base
end


# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  password   :string(255)
#  salt       :string(255)
#  sina_token :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean(1)      default(TRUE)
#

