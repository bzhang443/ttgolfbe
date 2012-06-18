require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
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

