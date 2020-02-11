class AddDefaultValueForLifetimePoints < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :lifetime_points, 0
  end
end
