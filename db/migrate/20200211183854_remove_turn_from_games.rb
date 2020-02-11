class RemoveTurnFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :turn
  end
end
