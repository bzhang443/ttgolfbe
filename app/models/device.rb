class Device < ActiveRecord::Base
end

# == Schema Information
#
# Table name: devices
#
#  id         :integer(4)      not null, primary key
#  did        :string(255)
#  model      :string(255)
#  os         :string(255)
#  version    :string(255)
#  source     :string(255)
#  token      :string(255)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

