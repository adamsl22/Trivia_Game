class AddTurnToGameUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :game_users, :turn, :integer
  end
end
