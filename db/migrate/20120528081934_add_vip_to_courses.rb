class AddVipToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :vip, :boolean

  end
end
