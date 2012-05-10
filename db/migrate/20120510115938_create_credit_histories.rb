class CreateCreditHistories < ActiveRecord::Migration
  def change
    create_table :credit_histories do |t|
      t.integer :user_id
      t.string :action
      t.integer :offset
      t.integer :course_id
      t.integer :club_id

      t.timestamps
    end
  end
end
