class AddPoiToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :position_tee_red, :string
    add_column :maps, :position_tee_white, :string
    add_column :maps, :position_tee_blue, :string
    add_column :maps, :position_tee_gold, :string
    add_column :maps, :position_tee_black, :string
    add_column :maps, :position_green_center, :string

  end
end
