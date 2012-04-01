class Club < ActiveRecord::Base
end


# == Schema Information
#
# Table name: clubs
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  area_id     :integer(4)
#  address     :string(255)
#  latitude    :decimal(9, 6)
#  longitude   :decimal(9, 6)
#  description :text
#  logo_url    :string(255)
#  telephone   :string(255)
#  active      :boolean(1)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  short_name  :string(255)
#

