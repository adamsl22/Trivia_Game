class AddBlurbToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :blurb, :string
  end
end
