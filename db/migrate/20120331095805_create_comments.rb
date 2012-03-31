class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :course_id
      t.integer :user_id
      t.decimal :overall
      t.decimal :view
      t.decimal :hardiness
      t.decimal :design
      t.decimal :recall
      t.decimal :maintenance
      t.decimal :culture
      t.decimal :candy
      t.decimal :facility
      t.decimal :service
      t.decimal :price
      t.string :notes

      t.timestamps
    end
    
    change_column :comments, :overall, :decimal, :precision => 3, :scale => 1
    change_column :comments, :view, :decimal, :precision => 3, :scale => 1
    change_column :comments, :hardiness, :decimal, :precision => 3, :scale => 1
    change_column :comments, :design, :decimal, :precision => 3, :scale => 1
    change_column :comments, :recall, :decimal, :precision => 3, :scale => 1
    change_column :comments, :maintenance, :decimal, :precision => 3, :scale => 1
    change_column :comments, :culture, :decimal, :precision => 3, :scale => 1
    change_column :comments, :candy, :decimal, :precision => 3, :scale => 1
    change_column :comments, :facility, :decimal, :precision => 3, :scale => 1
    change_column :comments, :service, :decimal, :precision => 3, :scale => 1
    change_column :comments, :price, :decimal, :precision => 3, :scale => 1
  end
end
