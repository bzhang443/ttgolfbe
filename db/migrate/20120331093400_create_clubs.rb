class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :area_id
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.text :description
      t.string :logo_url
      t.string :telephone
      t.boolean :active

      t.timestamps
    end
    
    change_column :clubs, :latitude, :decimal, :precision => 9, :scale => 6
    change_column :clubs, :longitude, :decimal, :precision => 9, :scale => 6
  end
end
