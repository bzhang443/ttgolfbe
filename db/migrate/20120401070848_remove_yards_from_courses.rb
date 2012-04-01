class RemoveYardsFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :yards
  end

  def down
    add_column :courses, :yards, :integer
  end
end
