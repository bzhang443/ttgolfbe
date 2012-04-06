class AddTypeToCourses < ActiveRecord::Migration
  def change
    # add_column :courses, :type, :string
    execute("ALTER TABLE courses add column type varchar(255) after name")
  end
end
