class RenameHardinessInComments < ActiveRecord::Migration
  def up
    rename_column :comments, :hardiness, :hardness
  end

  def down
  end
end
