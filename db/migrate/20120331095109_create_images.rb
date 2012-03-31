class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :url
      t.integer :club_id
      t.integer :course_id

      t.timestamps
    end
  end
end
