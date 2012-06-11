class AdjustFactorsToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :price
    remove_column :comments, :rational
    rename_column :comments, :candy, :service
  end
end
