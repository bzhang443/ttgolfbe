class AddMainPictureToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :main_picture, :string
  end
end
