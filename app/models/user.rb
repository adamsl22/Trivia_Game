class User < ApplicationRecord
    has_many :game_users
    has_many :games, through: :game_users
end
