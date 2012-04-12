class AddIndexOnDidToDevices < ActiveRecord::Migration
  def change
    add_index :devices, :did, :unique => true
  end
end
