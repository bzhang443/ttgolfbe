class MergePrices < ActiveRecord::Migration
  def change
    remove_column :prices, :time_slot
    rename_column :prices, :price,   :holiday
    add_column    :prices, :workday, :decimal
    change_column :prices, :workday, :decimal, :precision => 9, :scale => 2
  end
end
