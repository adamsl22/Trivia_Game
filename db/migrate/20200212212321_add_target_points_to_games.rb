class AddTargetPointsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :target_points, :integer
  end
end
