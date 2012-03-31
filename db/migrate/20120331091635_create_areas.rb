class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :level
      t.integer :upper_area

      t.timestamps
    end
  end
end
