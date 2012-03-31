class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.decimal :lat_left_lower
      t.decimal :lon_left_lower
      t.decimal :lat_right_lower
      t.decimal :lon_right_lower
      t.decimal :lat_left_higher
      t.decimal :lon_left_higher
      t.decimal :lat_right_higher
      t.decimal :lon_right_higher
      t.integer :dim_x
      t.integer :dim_y
      t.string :url

      t.timestamps
    end
    change_column :maps, :lat_left_lower, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lon_left_lower, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lat_right_lower, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lon_right_lower, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lat_left_higher, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lon_left_higher, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lat_right_higher, :decimal, :precision => 9, :scale => 6
    change_column :maps, :lon_right_higher, :decimal, :precision => 9, :scale => 6

  end
end
