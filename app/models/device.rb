require 'digest'

class Device < ActiveRecord::Base
  belongs_to :user
  
  def self.find_or_create(did, model, os, version, source)
    d = Device.find_by_did did
    if d 
      d.update_attributes(:model=>model, :os=>os, :version=>version, :source=>source)
    else
      u = User.create
      token = Digest::SHA2.hexdigest("#{Time.now.utc}|#{did}|#{u.id}")
      d = Device.create(:did=>did, :model=>model, :os=>os, :version=>version, :source=>source, :user_id=>u.id, :token=>token)
    end
    d
  end
  
  def update_token
    token = Digest::SHA2.hexdigest("#{Time.now.utc}|#{did}|#{user_id}")
    self.token = token
  end
  
  def switch_user(user)
    self.user = user
    update_token
  end  
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

