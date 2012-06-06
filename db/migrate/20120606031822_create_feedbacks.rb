class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :content
      t.string :email
      t.string :phone_number
      t.string :lat_lon
      t.string :source
      t.string :status

      t.timestamps
    end
  end
end
