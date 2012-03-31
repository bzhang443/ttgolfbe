class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :course_id
      t.string :time_slot
      t.decimal :price
      t.integer :agent_id

      t.timestamps
    end
    change_column :prices, :price, :decimal, :precision => 9, :scale => 2
  end
end
