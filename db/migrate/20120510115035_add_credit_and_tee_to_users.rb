class AddCreditAndTeeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit, :integer, :default=>0
    add_column :users, :tee, :string
  end
end
