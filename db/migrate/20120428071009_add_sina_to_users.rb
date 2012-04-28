class AddSinaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sina_expires, :datetime
    add_column :users, :sina_uid, :string
  end
end
