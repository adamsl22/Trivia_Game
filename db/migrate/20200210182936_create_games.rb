class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :turn
      t.string :category_1
      t.string :category_2
      t.string :category_3
      t.string :category_4
      t.string :category_5

      t.timestamps
    end
  end
end
