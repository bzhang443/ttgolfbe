class AddScoreModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score_mode, :string

  end
end
