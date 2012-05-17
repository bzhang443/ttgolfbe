class AddGreenFrontAndBackPoiToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :poi_green_front, :string
    add_column :maps, :poi_green_back, :string    
    rename_column :maps, :position_tee_black, :poi_tee_black
    rename_column :maps, :position_tee_gold, :poi_tee_gold
    rename_column :maps, :position_tee_blue, :poi_tee_blue
    rename_column :maps, :position_tee_white, :poi_tee_white
    rename_column :maps, :position_tee_red, :poi_tee_red
    rename_column :maps, :position_green_center, :poi_green_center
  end
end
