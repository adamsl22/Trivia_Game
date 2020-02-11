class AddDefaultValueForLevel < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :level, 1
  end
end
