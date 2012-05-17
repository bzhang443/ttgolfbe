class ChangeFactorsToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :service 
    remove_column :comments, :recall
    rename_column :comments, :culture, :rational
  end
end
