require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  active     :boolean(1)      default(TRUE)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

