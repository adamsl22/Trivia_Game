class User < ApplicationRecord
    has_secure_password
    
    has_many :game_users
    has_many :games, through: :game_users
end
