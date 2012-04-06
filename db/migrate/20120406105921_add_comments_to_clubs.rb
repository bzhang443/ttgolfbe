class AddCommentsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :comments, :text

  end
end
