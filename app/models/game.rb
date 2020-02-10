class Game < ApplicationRecord
    has_many :game_users
    has_many :users, through: :game_users
end
