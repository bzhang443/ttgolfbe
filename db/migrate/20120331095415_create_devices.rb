class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :did
      t.string :model
      t.string :os
      t.string :version
      t.string :source
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
