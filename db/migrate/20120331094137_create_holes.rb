class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :course_id
      t.integer :number
      t.integer :par
      t.integer :yard_black
      t.integer :yard_gold
      t.integer :yard_blue
      t.integer :yard_white
      t.integer :yard_red
      t.integer :map_id

      t.timestamps
    end
  end
end
