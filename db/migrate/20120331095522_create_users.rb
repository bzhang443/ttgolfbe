class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt
      t.string :sina_token
      t.boolean :active, :default=>true
      
      t.timestamps
    end
  end
end
