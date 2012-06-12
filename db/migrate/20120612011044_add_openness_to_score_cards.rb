class AddOpennessToScoreCards < ActiveRecord::Migration
  def change
    add_column :score_cards, :openness, :string, :default=>'public' # private, friends

  end
end
