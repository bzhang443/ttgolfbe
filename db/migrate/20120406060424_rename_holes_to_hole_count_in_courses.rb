class RenameHolesToHoleCountInCourses < ActiveRecord::Migration
  def up
    rename_column :courses, :holes, :hole_count
  end

  def down
  end
end
