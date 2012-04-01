class SetDefaultActiveToClubs < ActiveRecord::Migration
  def up
    change_column :clubs, :active, :boolean, :default=>true
    Club.all.each do |c|
      c.update_attributes! :active=>true
    end
  end

  def down
  end
end
