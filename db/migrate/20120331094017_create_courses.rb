class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :club_id
      t.string :name
      t.string :designer
      t.text :description
      t.integer :yards
      t.integer :holes
      t.integer :group_id

      t.timestamps
    end
  end
end
