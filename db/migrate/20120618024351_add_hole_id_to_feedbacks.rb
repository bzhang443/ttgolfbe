class AddHoleIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :hole_id, :integer
  end
end
